import SwiftUI
import StoreKit

// iOS 15 compatible underlined button
struct UnderlinedButton: View {
    let text: String
    let fontSize: CGFloat
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(text)
                    .font(.system(size: fontSize))
                    .foregroundColor(color)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(color)
            }
        }
    }
}

struct PurchaseView: View {
    @Binding var isPresented: Bool
    @StateObject private var storeManager = StoreManager.shared
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedProductID: ProductID = .yearlySubscription
    
    var body: some View {
        ZStack {
            // 深色渐变背景
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.05, green: 0.05, blue: 0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 顶部关闭按钮
                HStack {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, horizontalSizeClass == .regular ? 60 : 50)
                .padding(.bottom, 20)
                
                // 主要内容
                ScrollView(showsIndicators: false) {
                    VStack(spacing: horizontalSizeClass == .regular ? 32 : 24) {
                        // 标题部分
                        VStack(spacing: horizontalSizeClass == .regular ? 16 : 12) {
                            Text("Premium Unlock")
                                .font(.system(size: horizontalSizeClass == .regular ? 36 : 28, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            Text("Choose Your Plan")
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        
                        // 定价方案
                        VStack(spacing: 12) {
                            ForEach(ProductID.allCases, id: \.self) { productID in
                                if let product = storeManager.getProduct(for: productID) {
                                    pricingCard(
                                        productID: productID,
                                        product: product,
                                        isSelected: selectedProductID == productID
                                    )
                                    .onTapGesture {
                                        selectedProductID = productID
                                    }
                                } else {
                                    // 产品未加载时显示占位符
                                    pricingCardPlaceholder(
                                        productID: productID,
                                        isSelected: selectedProductID == productID
                                    )
                                    .onTapGesture {
                                        selectedProductID = productID
                                    }
                                }
                            }
                        }
                        
                        // 功能列表
                        VStack(alignment: .leading, spacing: horizontalSizeClass == .regular ? 16 : 12) {
                            Text("What You Get:")
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: horizontalSizeClass == .regular ? 12 : 8) {
                                benefitRow("All categories unlocked")
                                benefitRow("No ads")
                                benefitRow("Custom words & categories")
                                benefitRow("Free lifetime updates")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // 订阅按钮
                        Button(action: {
                            purchaseSelectedPlan()
                        }) {
                            HStack {
                                if storeManager.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                } else {
                                    Text("Subscribe Now")
                                        .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: horizontalSizeClass == .regular ? 56 : 50)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.orange, Color.red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                            .shadow(color: Color.orange.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .disabled(storeManager.isLoading)
                        
                        // 条款和链接
                        VStack(spacing: 8) {
                            Text("Terms apply. Subscription automatically renews unless cancelled.")
                                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                                .foregroundColor(.white.opacity(0.6))
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 20) {
                                UnderlinedButton(
                                    text: "Privacy Policy",
                                    fontSize: horizontalSizeClass == .regular ? 12 : 10,
                                    color: .white.opacity(0.8)
                                ) { }
                                
                                UnderlinedButton(
                                    text: "Terms of Use",
                                    fontSize: horizontalSizeClass == .regular ? 12 : 10,
                                    color: .white.opacity(0.8)
                                ) { }
                                
                                UnderlinedButton(
                                    text: "Restore",
                                    fontSize: horizontalSizeClass == .regular ? 12 : 10,
                                    color: .white.opacity(0.8)
                                ) { 
                                    Task {
                                        await storeManager.restorePurchases()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            Task {
                await storeManager.loadProducts()
            }
        }
        .alert("购买超时", isPresented: $storeManager.showTimeoutAlert) {
            Button("重试") {
                Task {
                    await storeManager.retryLastOperation()
                }
            }
            Button("取消", role: .cancel) { }
        } message: {
            Text(storeManager.timeoutMessage)
        }
        .alert("购买成功", isPresented: $storeManager.purchaseSuccess) {
            Button("确定") {
                isPresented = false
            }
        } message: {
            Text("感谢您的购买！专业版功能已解锁。")
        }
        .alert("恢复成功", isPresented: $storeManager.restoreSuccess) {
            Button("确定") {
                isPresented = false
            }
        } message: {
            Text("您的购买已成功恢复！")
        }
        .alert("错误", isPresented: .constant(storeManager.errorMessage != nil)) {
            Button("确定") {
                storeManager.errorMessage = nil
            }
        } message: {
            Text(storeManager.errorMessage ?? "")
        }
    }
    
    // 使用真实产品数据的定价卡片
    private func pricingCard(productID: ProductID, product: Product, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(getDisplayTitle(for: productID))
                            .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        if let badge = getBadge(for: productID) {
                            Text(badge)
                                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10, weight: .bold))
                                .foregroundColor(productID == .yearlySubscription ? .orange : .green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill((productID == .yearlySubscription ? Color.orange : Color.green).opacity(0.2))
                                )
                        }
                    }
                    
                    Text(formatPrice(for: product, productID: productID))
                        .font(.system(size: horizontalSizeClass == .regular ? 16 : 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            if productID == .yearlySubscription {
                VStack(alignment: .leading, spacing: 4) {
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    Text("✦ Save 58% vs monthly\n✦ Only $1.67 per month")
                        .font(.system(size: horizontalSizeClass == .regular ? 14 : 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                }
            } else if productID == .lifetimeSubscription {
                VStack(alignment: .leading, spacing: 4) {
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    Text("✦ Pay once, use forever\n✦ No future charges")
                        .font(.system(size: horizontalSizeClass == .regular ? 14 : 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
                )
        )
    }
    
    // 产品未加载时的占位符
    private func pricingCardPlaceholder(productID: ProductID, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(getDisplayTitle(for: productID))
                            .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        if let badge = getBadge(for: productID) {
                            Text(badge)
                                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10, weight: .bold))
                                .foregroundColor(productID == .yearlySubscription ? .orange : .green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill((productID == .yearlySubscription ? Color.orange : Color.green).opacity(0.2))
                                )
                        }
                    }
                    
                    Text(getPlaceholderPrice(for: productID))
                        .font(.system(size: horizontalSizeClass == .regular ? 16 : 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
                )
        )
    }
    
    private func benefitRow(_ text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: horizontalSizeClass == .regular ? 18 : 16))
                .foregroundColor(.green)
            
            Text(text)
                .font(.system(size: horizontalSizeClass == .regular ? 16 : 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
    
    // 真实的购买功能
    private func purchaseSelectedPlan() {
        guard let product = storeManager.getProduct(for: selectedProductID) else {
            print("❌ 产品未找到: \(selectedProductID)")
            return
        }
        
        Task {
            do {
                let transaction = try await storeManager.purchase(product)
                if transaction != nil {
                    // 购买成功，关闭界面
                    await MainActor.run {
                        isPresented = false
                    }
                }
            } catch {
                print("❌ 购买失败: \(error)")
                // 错误处理已在StoreManager中完成
            }
        }
    }
    
    // 辅助方法
    private func getDisplayTitle(for productID: ProductID) -> String {
        switch productID {
        case .weeklySubscription:
            return "Weekly"
        case .monthlySubscription:
            return "Monthly"
        case .yearlySubscription:
            return "Yearly"
        case .lifetimeSubscription:
            return "Lifetime"
        }
    }
    
    private func getBadge(for productID: ProductID) -> String? {
        switch productID {
        case .weeklySubscription:
            return "3-day free trial"
        case .monthlySubscription:
            return nil
        case .yearlySubscription:
            return "BEST VALUE"
        case .lifetimeSubscription:
            return "ONE-TIME PAY"
        }
    }
    
    private func formatPrice(for product: Product, productID: ProductID) -> String {
        switch productID {
        case .weeklySubscription:
            return "\(product.displayPrice) / week"
        case .monthlySubscription:
            return "\(product.displayPrice) / month"
        case .yearlySubscription:
            return "\(product.displayPrice) / year"
        case .lifetimeSubscription:
            return product.displayPrice
        }
    }
    
    private func getPlaceholderPrice(for productID: ProductID) -> String {
        switch productID {
        case .weeklySubscription:
            return "$1.99 / week"
        case .monthlySubscription:
            return "$3.99 / month"
        case .yearlySubscription:
            return "$19.99 / year"
        case .lifetimeSubscription:
            return "$24.99"
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(isPresented: .constant(true))
    }
}