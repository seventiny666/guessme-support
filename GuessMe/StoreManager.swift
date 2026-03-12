import StoreKit
import SwiftUI

/*
 App Store Connect 配置要点：
 
 1. 创建订阅群组 (Subscription Group)：
    - 登录 App Store Connect
    - 选择你的应用 → 功能 → App 内购买项目
    - 创建订阅群组，例如："Premium Subscriptions"
 
 2. 创建自动续期订阅产品：
    - 产品ID必须与下面的ProductID枚举值完全一致
    - 设置价格层级（Price Tier）
    - 配置免费试用期（如需要）
    - 设置订阅时长（1周/1月/1年）
 
 3. 沙盒测试配置：
    - 创建沙盒测试用户账号
    - 在设备上登录沙盒账号进行测试
    - 沙盒环境下订阅会快速过期便于测试
 
 4. 必需的应用审核信息：
    - 提供订阅服务的详细描述
    - 说明自动续费机制
    - 提供取消订阅的说明
*/

// 订阅产品 ID - 必须与App Store Connect中配置的产品ID完全一致
enum ProductID: String, CaseIterable {
    case weeklySubscription = "com.seventinygame.app.weekly"     // 周订阅
    case monthlySubscription = "com.seventinygame.app.monthly"   // 月订阅  
    case yearlySubscription = "com.seventinygame.app.yearly"     // 年订阅
    case lifetimeSubscription = "com.seventinygame.app.lifetime" // 终身版（一次性购买）
    
    var displayName: String {
        switch self {
        case .weeklySubscription:
            return "专业版周订阅"
        case .monthlySubscription:
            return "专业版月订阅"
        case .yearlySubscription:
            return "专业版年订阅"
        case .lifetimeSubscription:
            return "专业版终身版"
        }
    }
    
    var description: String {
        switch self {
        case .weeklySubscription:
            return "3天免费试用，之后每周$1.99"
        case .monthlySubscription:
            return "每月$3.99"
        case .yearlySubscription:
            return "每年$19.99，最超值选择"
        case .lifetimeSubscription:
            return "一次性付费$24.99，永久使用"
        }
    }
    
    // 是否为自动续订类型
    var isAutoRenewing: Bool {
        switch self {
        case .weeklySubscription, .monthlySubscription, .yearlySubscription:
            return true
        case .lifetimeSubscription:
            return false
        }
    }
}

@MainActor
class StoreManager: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs: Set<String> = []
    @Published private(set) var subscriptionInfo: SubscriptionInfo?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showTimeoutAlert = false
    @Published var timeoutMessage = ""
    @Published var purchaseSuccess = false
    @Published var restoreSuccess = false
    
    // MARK: - Private Properties
    private var updateListenerTask: Task<Void, Error>?
    private let timeoutDuration: TimeInterval = 15.0
    private let userDefaults = UserDefaults.standard
    
    // 持久化键值
    private enum UserDefaultsKeys {
        static let hasProVersion = "hasProVersion"
        static let subscriptionExpirationDate = "subscriptionExpirationDate"
        static let lastActiveProductID = "lastActiveProductID"
    }
    
    // 单例
    static let shared = StoreManager()
    
    private init() {
        // 启动时恢复本地订阅状态
        restoreLocalSubscriptionState()
        
        // 监听交易更新
        updateListenerTask = listenForTransactions()
        
        // 异步加载产品和更新订阅状态
        Task {
            await loadProducts()
            await updatePurchasedProducts()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    // MARK: - Public Methods
    
    /// 加载所有订阅产品
    func loadProducts() async {
        guard products.isEmpty else { return } // 避免重复加载
        
        isLoading = true
        errorMessage = nil
        
        do {
            let productIDs = ProductID.allCases.map { $0.rawValue }
            let loadedProducts = try await Product.products(for: productIDs)
            
            // 按照预定义顺序排序产品
            self.products = ProductID.allCases.compactMap { productID in
                loadedProducts.first { $0.id == productID.rawValue }
            }
            
            print("✅ 成功加载 \(products.count) 个产品")
            
        } catch {
            print("❌ 加载产品失败: \(error)")
            errorMessage = "无法加载产品信息，请检查网络连接"
        }
        
        isLoading = false
    }
    
    /// 购买指定产品
    func purchase(_ product: Product) async throws -> StoreKit.Transaction? {
        isLoading = true
        errorMessage = nil
        showTimeoutAlert = false
        purchaseSuccess = false
        
        defer {
            isLoading = false
        }
        
        // 创建超时任务
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: UInt64(timeoutDuration * 1_000_000_000))
            if !Task.isCancelled {
                await MainActor.run {
                    self.isLoading = false
                    self.timeoutMessage = "购买请求超时，请检查网络后重试"
                    self.showTimeoutAlert = true
                }
            }
        }
        
        do {
            let result = try await product.purchase()
            timeoutTask.cancel()
            
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                
                // 更新订阅状态
                await updatePurchasedProducts()
                
                // 完成交易
                await transaction.finish()
                
                // 保存到本地
                saveSubscriptionState(for: transaction)
                
                purchaseSuccess = true
                print("✅ 购买成功: \(product.displayName)")
                
                return transaction
                
            case .userCancelled:
                print("ℹ️ 用户取消购买")
                return nil
                
            case .pending:
                print("⏳ 购买待处理（需要家长批准等）")
                errorMessage = "购买正在处理中，请稍后查看"
                return nil
                
            @unknown default:
                throw StoreError.purchaseFailed("未知购买结果")
            }
            
        } catch {
            timeoutTask.cancel()
            
            if showTimeoutAlert {
                throw StoreError.timeout
            }
            
            let errorMsg = error.localizedDescription
            print("❌ 购买失败: \(errorMsg)")
            throw StoreError.purchaseFailed(errorMsg)
        }
    }
    
    /// 恢复购买
    func restorePurchases() async {
        isLoading = true
        errorMessage = nil
        showTimeoutAlert = false
        restoreSuccess = false
        
        defer {
            isLoading = false
        }
        
        // 创建超时任务
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: UInt64(timeoutDuration * 1_000_000_000))
            if !Task.isCancelled {
                await MainActor.run {
                    self.isLoading = false
                    self.timeoutMessage = "恢复购买超时，请检查网络后重试"
                    self.showTimeoutAlert = true
                }
            }
        }
        
        do {
            // 同步App Store状态
            try await AppStore.sync()
            timeoutTask.cancel()
            
            // 更新本地订阅状态
            await updatePurchasedProducts()
            
            if hasProVersion {
                restoreSuccess = true
                print("✅ 恢复购买成功")
            } else {
                errorMessage = "未找到可恢复的购买记录"
                print("ℹ️ 未找到有效的订阅")
            }
            
        } catch {
            timeoutTask.cancel()
            
            if !showTimeoutAlert {
                let errorMsg = error.localizedDescription
                errorMessage = "恢复购买失败：\(errorMsg)"
                print("❌ 恢复购买失败: \(errorMsg)")
            }
        }
    }
    
    /// 重试操作
    func retryLastOperation() async {
        showTimeoutAlert = false
        
        // 重新加载产品和更新状态
        await loadProducts()
        await updatePurchasedProducts()
    }
    
    // MARK: - Private Methods
    
    /// 更新已购买产品状态
    func updatePurchasedProducts() async {
        var purchasedIDs: Set<String> = []
        var latestSubscription: SubscriptionInfo?
        
        // 遍历所有当前权益
        for await result in StoreKit.Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                purchasedIDs.insert(transaction.productID)
                
                // 如果是订阅产品，获取详细信息
                if let productID = ProductID(rawValue: transaction.productID) {
                    let subscriptionInfo = await getSubscriptionInfo(for: transaction, productID: productID)
                    
                    // 保存最新的有效订阅信息
                    if subscriptionInfo.status.isActive {
                        if latestSubscription == nil || 
                           subscriptionInfo.expirationDate ?? Date.distantFuture > latestSubscription?.expirationDate ?? Date.distantPast {
                            latestSubscription = subscriptionInfo
                        }
                    }
                }
                
            } catch {
                print("❌ 验证交易失败: \(error)")
            }
        }
        
        // 更新状态
        self.purchasedProductIDs = purchasedIDs
        self.subscriptionInfo = latestSubscription
        
        // 保存到本地
        saveLocalSubscriptionState()
        
        print("📱 订阅状态更新: \(purchasedIDs.count) 个有效产品")
    }
    
    /// 获取订阅详细信息
    private func getSubscriptionInfo(for transaction: StoreKit.Transaction, productID: ProductID) async -> SubscriptionInfo {
        let purchaseDate = transaction.purchaseDate
        let expirationDate = transaction.expirationDate
        let isInTrial = transaction.offerType == .introductory
        
        // 检查订阅状态
        let status: SubscriptionStatus
        if let expiration = expirationDate {
            if expiration > Date() {
                status = .active
            } else {
                status = .expired
            }
        } else {
            // 终身版没有过期时间
            status = .active
        }
        
        return SubscriptionInfo(
            productID: transaction.productID,
            purchaseDate: purchaseDate,
            expirationDate: expirationDate,
            isInTrial: isInTrial,
            willAutoRenew: productID.isAutoRenewing && status == .active,
            status: status
        )
    }
    
    /// 监听交易更新
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached { [weak self] in
            guard let self = self else { return }
            
            for await result in StoreKit.Transaction.updates {
                do {
                    let transaction = try await self.checkVerified(result)
                    
                    await MainActor.run {
                        print("🔄 收到交易更新: \(transaction.productID)")
                    }
                    
                    // 更新订阅状态
                    await self.updatePurchasedProducts()
                    
                    // 完成交易
                    await transaction.finish()
                    
                    // 保存状态
                    await MainActor.run {
                        self.saveSubscriptionState(for: transaction)
                    }
                    
                } catch {
                    await MainActor.run {
                        print("❌ 处理交易更新失败: \(error)")
                    }
                }
            }
        }
    }
    
    /// 验证交易
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    /// 保存订阅状态到本地
    private func saveSubscriptionState(for transaction: StoreKit.Transaction) {
        userDefaults.set(true, forKey: UserDefaultsKeys.hasProVersion)
        userDefaults.set(transaction.productID, forKey: UserDefaultsKeys.lastActiveProductID)
        
        if let expirationDate = transaction.expirationDate {
            userDefaults.set(expirationDate, forKey: UserDefaultsKeys.subscriptionExpirationDate)
        }
        
        print("💾 订阅状态已保存到本地")
    }
    
    /// 保存当前订阅状态到本地
    private func saveLocalSubscriptionState() {
        let hasActive = subscriptionInfo?.status.isActive ?? false
        userDefaults.set(hasActive, forKey: UserDefaultsKeys.hasProVersion)
        
        if let info = subscriptionInfo {
            userDefaults.set(info.productID, forKey: UserDefaultsKeys.lastActiveProductID)
            if let expirationDate = info.expirationDate {
                userDefaults.set(expirationDate, forKey: UserDefaultsKeys.subscriptionExpirationDate)
            }
        }
    }
    
    /// 从本地恢复订阅状态
    private func restoreLocalSubscriptionState() {
        let hasProVersion = userDefaults.bool(forKey: UserDefaultsKeys.hasProVersion)
        let lastProductID = userDefaults.string(forKey: UserDefaultsKeys.lastActiveProductID)
        let expirationDate = userDefaults.object(forKey: UserDefaultsKeys.subscriptionExpirationDate) as? Date
        
        // 检查本地保存的订阅是否仍然有效
        if hasProVersion, let productID = lastProductID {
            if let expiration = expirationDate {
                if expiration > Date() {
                    // 订阅仍然有效，创建临时订阅信息
                    self.subscriptionInfo = SubscriptionInfo(
                        productID: productID,
                        purchaseDate: Date(), // 临时值，会在网络更新时替换
                        expirationDate: expiration,
                        isInTrial: false,
                        willAutoRenew: ProductID(rawValue: productID)?.isAutoRenewing ?? false,
                        status: .active
                    )
                    self.purchasedProductIDs.insert(productID)
                    print("📱 从本地恢复订阅状态: \(productID)")
                }
            } else {
                // 终身版没有过期时间
                self.subscriptionInfo = SubscriptionInfo(
                    productID: productID,
                    purchaseDate: Date(),
                    expirationDate: nil,
                    isInTrial: false,
                    willAutoRenew: false,
                    status: .active
                )
                self.purchasedProductIDs.insert(productID)
                print("📱 从本地恢复终身版状态")
            }
        }
    }
    
    // MARK: - Public Computed Properties
    
    /// 检查是否拥有专业版权限
    var hasProVersion: Bool {
        return subscriptionInfo?.status.isActive ?? false
    }
    
    /// 获取当前订阅状态
    var subscriptionStatus: SubscriptionStatus {
        return subscriptionInfo?.status ?? .notSubscribed
    }
    
    /// 是否在试用期
    var isInTrialPeriod: Bool {
        return subscriptionInfo?.isInTrial ?? false
    }
    
    /// 订阅是否会自动续费
    var willAutoRenew: Bool {
        return subscriptionInfo?.willAutoRenew ?? false
    }
    
    /// 订阅过期时间
    var subscriptionExpirationDate: Date? {
        return subscriptionInfo?.expirationDate
    }
    
    /// 当前活跃的产品ID
    var activeProductID: String? {
        return subscriptionInfo?.productID
    }
    
    // MARK: - Utility Methods
    
    /// 获取产品价格显示文本
    func getProductPrice(_ productID: ProductID) -> String {
        if let product = products.first(where: { $0.id == productID.rawValue }) {
            return product.displayPrice
        }
        
        // 默认价格（当产品未加载时）
        switch productID {
        case .weeklySubscription:
            return "$1.99/周"
        case .monthlySubscription:
            return "$3.99/月"
        case .yearlySubscription:
            return "$19.99/年"
        case .lifetimeSubscription:
            return "$24.99"
        }
    }
    
    /// 获取产品对象
    func getProduct(for productID: ProductID) -> Product? {
        return products.first { $0.id == productID.rawValue }
    }
    
    /// 获取试用期信息
    func getTrialInfo(for productID: ProductID) -> String? {
        guard let product = getProduct(for: productID) else { return nil }
        
        // 检查是否有试用期优惠
        if let subscription = product.subscription,
           let introOffer = subscription.introductoryOffer,
           introOffer.paymentMode == .freeTrial {
            
            let period = introOffer.period
            switch period.unit {
            case .day:
                return "\(period.value)天免费试用"
            case .week:
                return "\(period.value)周免费试用"
            case .month:
                return "\(period.value)个月免费试用"
            case .year:
                return "\(period.value)年免费试用"
            @unknown default:
                return "免费试用"
            }
        }
        
        return nil
    }
    
    /// 格式化订阅到期时间
    func formatExpirationDate() -> String? {
        guard let expirationDate = subscriptionExpirationDate else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        
        return formatter.string(from: expirationDate)
    }
    
    /// 检查订阅是否即将到期（7天内）
    var isSubscriptionExpiringSoon: Bool {
        guard let expirationDate = subscriptionExpirationDate else { return false }
        let sevenDaysFromNow = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
        return expirationDate <= sevenDaysFromNow && expirationDate > Date()
    }
}

// MARK: - 合规订阅说明文案

extension StoreManager {
    
    /// 获取自动续费说明文案
    static func getAutoRenewalTerms() -> String {
        return """
        自动续费说明：
        
        • 订阅会在当前订阅周期结束前24小时自动续费
        • 除非在当前订阅周期结束前至少24小时关闭自动续费，否则订阅会自动续费
        • 自动续费的费用将在当前订阅周期结束前24小时内从您的iTunes账户中扣除
        • 用户可以管理订阅，购买后可在用户的iTunes账户设置中关闭自动续费
        
        取消订阅方法：
        1. 打开iPhone的"设置"应用
        2. 点击您的姓名，然后点击"媒体与购买项目"
        3. 点击"查看账户"，您可能需要登录
        4. 点击"订阅"
        5. 找到此应用的订阅并点击
        6. 点击"取消订阅"
        
        注意：删除应用不会取消订阅
        """
    }
    
    /// 获取隐私政策和服务条款链接说明
    static func getPrivacyAndTermsInfo() -> String {
        return """
        使用条款：https://your-app-website.com/terms
        隐私政策：https://your-app-website.com/privacy
        
        继续订阅即表示您同意上述条款和政策。
        """
    }
    
    /// 获取退款政策说明
    static func getRefundPolicy() -> String {
        return """
        退款政策：
        
        • 所有订阅购买都通过Apple App Store处理
        • 如需退款，请联系Apple客服
        • 退款政策遵循Apple App Store的标准条款
        • 免费试用期内取消不会产生费用
        """
    }
}

// 订阅状态枚举
enum SubscriptionStatus: Equatable {
    case notSubscribed          // 未订阅
    case active                // 订阅有效
    case expired               // 订阅已过期
    case inGracePeriod         // 宽限期（支付问题但仍可使用）
    case inBillingRetryPeriod  // 计费重试期
    case revoked               // 订阅被撤销
    
    var isActive: Bool {
        switch self {
        case .active, .inGracePeriod, .inBillingRetryPeriod:
            return true
        default:
            return false
        }
    }
}

// 订阅信息详情
struct SubscriptionInfo {
    let productID: String
    let purchaseDate: Date
    let expirationDate: Date?
    let isInTrial: Bool
    let willAutoRenew: Bool
    let status: SubscriptionStatus
}

// 错误类型
enum StoreError: Error, LocalizedError {
    case failedVerification
    case timeout
    case networkError
    case productNotFound
    case purchaseFailed(String)
    case restoreFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return "交易验证失败"
        case .timeout:
            return "网络请求超时"
        case .networkError:
            return "网络连接错误"
        case .productNotFound:
            return "产品未找到"
        case .purchaseFailed(let message):
            return "购买失败：\(message)"
        case .restoreFailed(let message):
            return "恢复购买失败：\(message)"
        }
    }
}
