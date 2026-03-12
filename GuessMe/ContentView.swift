import SwiftUI
import StoreKit

// 自定义TextEditor包装器 - 移除白色背景
struct CustomTextEditor: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        
        init(_ text: Binding<String>) {
            _text = text
        }
        
        func textViewDidChange(_ textView: UITextView) {
            _text.wrappedValue = textView.text
        }
    }
}

// 游戏规则弹窗
struct GameRulesView: View {
    @Binding var isPresented: Bool
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 0) {
                // 标题
                Text(languageManager.localizedString("game_rules"))
                    .font(.system(size: horizontalSizeClass == .regular ? 39 : 22, weight: .bold)) // iPhone恢复到22px
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .padding(.top, horizontalSizeClass == .regular ? 60 : 40) // iPhone恢复到40px
                
                Spacer()
                
                // 内容
                ScrollView {
                    Text(languageManager.localizedString("game_rules_content"))
                        .font(.system(size: horizontalSizeClass == .regular ? 27 : 16)) // iPhone恢复到16px
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, horizontalSizeClass == .regular ? 0 : 30) // iPhone减少到30px
                }
                .frame(height: horizontalSizeClass == .regular ? 315 : 220) // iPhone减少到220px
                
                Spacer()
                
                // 按钮
                Button(action: {
                    isPresented = false
                }) {
                    Text(languageManager.localizedString("i_know"))
                        .font(.system(size: horizontalSizeClass == .regular ? 27 : 16, weight: .bold)) // iPhone恢复到16px
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: horizontalSizeClass == .regular ? 81 : 48) // iPhone恢复到48px
                        .background(Color.appPrimary)
                        .cornerRadius(horizontalSizeClass == .regular ? 18 : 12) // iPhone恢复到12px
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 75 : 30) // iPhone减少到30px
                .padding(.bottom, horizontalSizeClass == .regular ? 66 : 44) // iPhone恢复到44px
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 750 : 350) // iPhone减少到350px
            .frame(height: horizontalSizeClass == .regular ? 675 : 380) // iPhone减少到380px
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(horizontalSizeClass == .regular ? 30 : 20) // iPhone恢复到20px
            .shadow(color: Color.black.opacity(0.3), radius: horizontalSizeClass == .regular ? 30 : 20, x: 0, y: horizontalSizeClass == .regular ? 15 : 10) // iPhone恢复
            .padding(.horizontal, horizontalSizeClass == .regular ? 90 : 30) // iPhone减少到30px
        }
    }
}

// Toast提示组件
struct ToastView: View {
    let message: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(message)
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.8))
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

// 游戏退出确认弹窗
struct GameExitConfirmView: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 标题
                Text(languageManager.localizedString("confirm_exit"))
                    .font(.system(size: horizontalSizeClass == .regular ? 26 : 22, weight: .bold))
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .padding(.top, 40)
                
                Spacer()
                
                // 消息
                Text(languageManager.localizedString("game_in_progress"))
                    .font(.system(size: horizontalSizeClass == .regular ? 18 : 16))
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // 按钮
                HStack(spacing: 12) {
                    Button(action: onCancel) {
                        Text(languageManager.localizedString("cancel"))
                            .font(.system(size: horizontalSizeClass == .regular ? 18 : 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: horizontalSizeClass == .regular ? 58 : 52) // 高度+4px：54→58 (iPad), 48→52 (iPhone)
                            .background(Color.gray)
                            .cornerRadius(12)
                    }
                    
                    Button(action: onConfirm) {
                        Text(languageManager.localizedString("exit"))
                            .font(.system(size: horizontalSizeClass == .regular ? 18 : 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: horizontalSizeClass == .regular ? 58 : 52) // 高度+4px：54→58 (iPad), 48→52 (iPhone)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 44)
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 380)
            .frame(height: horizontalSizeClass == .regular ? 300 : 260)
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 30)
        }
    }
}

// 游戏结束弹窗
struct GameOverView: View {
    let score: Int
    let onDismiss: () -> Void
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 标题
                Text(languageManager.localizedString("game_over"))
                    .font(.system(size: horizontalSizeClass == .regular ? 28 : 22, weight: .bold)) // iPhone减小到22px
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .padding(.top, horizontalSizeClass == .regular ? 40 : 35) // iPhone减小顶部间距
                
                Spacer()
                
                // 分数 - 移到上面
                Text("\(score)")
                    .font(.system(size: horizontalSizeClass == .regular ? 72 : 54, weight: .bold)) // iPhone减小到54px
                    .foregroundColor(.green)
                
                // 答对总数文字 - 移到下面
                Text(languageManager.localizedString("total_score_label"))
                    .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .medium)) // iPhone减小到16px
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .padding(.top, 12) // 改为顶部间距
                
                Spacer()
                
                // 返回首页按钮
                Button(action: onDismiss) {
                    Text(languageManager.localizedString("back_to_home"))
                        .font(.system(size: horizontalSizeClass == .regular ? 24 : 18, weight: .bold)) // iPhone减小到18px
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: horizontalSizeClass == .regular ? 70 : 54) // iPhone减小到54px
                        .background(Color.green)
                        .cornerRadius(12)
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 50 : 30) // iPhone减小到30px
                .padding(.bottom, horizontalSizeClass == .regular ? 44 : 35) // iPhone减小到35px
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 340) // iPhone减小到340px
            .frame(height: horizontalSizeClass == .regular ? 450 : 340) // iPhone减小到340px
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 10)
        }
    }
}

// Toast管理器
class ToastManager: ObservableObject {
    @Published var showToast = false
    @Published var toastMessage = ""
    
    func show(_ message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
}

struct ContentView: View {
    @StateObject private var storeManager = StoreManager.shared
    @ObservedObject var categoryManager = CustomCategoryManager.shared  // 改为@ObservedObject
    @StateObject private var toastManager = ToastManager()
    @StateObject private var languageManager = LanguageManager.shared
    @State private var showTimeModal = false
    @State private var selectedCategory: GameCategory?
    @State private var selectedCustomCategory: CustomCategory?
    @State private var selectedTime = 60
    @State private var showRules = false
    @State private var showPrivacyPolicy = false
    @State private var showPurchaseView = false
    @State private var showCustomCategory = false
    @State private var showLanguageSelector = false
    @State private var navigateToGame = false
    @State private var navigateToCustomGame = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let timeOptions = [30, 60, 90, 120] // 增加120秒选项
    
    // 根据设备类型动态调整列数和间距
    var columns: [GridItem] {
        let isIPad = horizontalSizeClass == .regular
        // iPad使用4列，iPhone使用2列，增加间距
        let spacing: CGFloat = isIPad ? 25 : 20
        return Array(repeating: GridItem(.flexible(), spacing: spacing), count: isIPad ? 4 : 2)
    }
    
    // 添加调试信息
    init() {
        print("🏠 ContentView初始化")
        print("🏠 自定义分类数量: \(CustomCategoryManager.shared.customCategories.count)")
        for category in CustomCategoryManager.shared.customCategories {
            print("🏠 - \(category.name): \(category.words.count) 个词汇")
        }
    }
    
    var body: some View {
        NavigationView {
            if horizontalSizeClass == .regular {
                // iPad布局 - 使用GeometryReader和绝对定位
                iPadLayout
            } else {
                // iPhone布局 - 使用传统VStack流式布局
                iPhoneLayout
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .overlay(overlayContent)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showTimeModal)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showPrivacyPolicy)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showPurchaseView)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showCustomCategory)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showLanguageSelector)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: toastManager.showToast)
    }
    
    // iPad专用布局
    private var iPadLayout: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top header
                    topHeader
                        .frame(height: 160)
                    
                    // Card grid
                    CardGridView(
                        categoryManager: categoryManager,
                        storeManager: storeManager,
                        languageManager: languageManager,
                        toastManager: toastManager,
                        columns: columns,
                        horizontalSizeClass: horizontalSizeClass,
                        showPurchaseView: $showPurchaseView,
                        showTimeModal: $showTimeModal,
                        selectedCategory: $selectedCategory,
                        selectedCustomCategory: $selectedCustomCategory
                    )
                    
                    Spacer(minLength: 0)
                    
                    // Bottom placeholder
                    Color.clear.frame(height: 160)
                }
                
                // Bottom buttons - 绝对定位
                bottomButtons
                    .background(Color.clear) // iPad: 去掉渐变背景
                    .position(
                        x: geometry.size.width / 2,
                        y: geometry.size.height - 70
                    )
                    .zIndex(9999)
                
                // Navigation links
                navigationLinks
            }
            .ignoresSafeArea(.all)
        }
    }
    
    // iPhone专用布局 - 传统VStack流式布局
    private var iPhoneLayout: some View {
        ZStack {
            // Background
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top header
                topHeader
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                
                // Card grid
                CardGridView(
                    categoryManager: categoryManager,
                    storeManager: storeManager,
                    languageManager: languageManager,
                    toastManager: toastManager,
                    columns: columns,
                    horizontalSizeClass: horizontalSizeClass,
                    showPurchaseView: $showPurchaseView,
                    showTimeModal: $showTimeModal,
                    selectedCategory: $selectedCategory,
                    selectedCustomCategory: $selectedCustomCategory
                )
                
                Spacer(minLength: 0)
                
                // Bottom buttons - 在VStack内部，流式布局
                bottomButtons
                    .padding(.horizontal, 15)
                    .padding(.bottom, 30)
            }
            
            // Navigation links
            navigationLinks
        }
    }
    
    // 顶部标题栏组件
    private var topHeader: some View {
        HStack(spacing: 0) {
            // Language button
            Button(action: { showLanguageSelector = true }) {
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: horizontalSizeClass == .regular ? 62 : 37, height: horizontalSizeClass == .regular ? 62 : 37)
                    
                    Text(languageManager.currentLanguage.flag)
                        .font(.system(size: horizontalSizeClass == .regular ? 28 : 17))
                }
            }
            .padding(.leading, horizontalSizeClass == .regular ? 60 : 25)
            
            Spacer()
            
            // Title
            Text(languageManager.localizedString("app_title"))
                .font(.system(size: horizontalSizeClass == .regular ? 28 : 28, weight: .bold)) // iPad: 56 / 2 = 28
                .foregroundColor(.white)
                .shadow(radius: 0)
            
            Spacer()
            
            // Rules button
            Button(action: { showRules = true }) {
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: horizontalSizeClass == .regular ? 62 : 37, height: horizontalSizeClass == .regular ? 62 : 37)
                    
                    Image(systemName: "book.fill")
                        .font(.system(size: horizontalSizeClass == .regular ? 28 : 17))
                        .foregroundColor(.white)
                }
            }
            .padding(.trailing, horizontalSizeClass == .regular ? 60 : 25)
        }
    }
    
    // 底部按钮组件
    private var bottomButtons: some View {
        VStack(spacing: 15) {
            HStack(spacing: horizontalSizeClass == .regular ? 40 : 15) {
                Button(action: {
                    if storeManager.hasProVersion {
                        showCustomCategory = true
                    } else {
                        showPurchaseView = true
                    }
                }) {
                    if horizontalSizeClass == .regular && storeManager.hasProVersion {
                        // iPad 订阅用户专用布局
                        VStack(spacing: 4) {
                            Text(languageManager.localizedString("create_category"))
                                .font(.system(size: 20, weight: .medium))
                            Text(languageManager.localizedString("edit_cards_hint_ipad"))
                                .font(.system(size: 12, weight: .regular))
                        }
                        .foregroundColor(.white)
                        .frame(width: 380, height: 78) // 宽度+20px, 高度+10px
                        .background(Color.green)
                        .cornerRadius(12)
                    } else {
                        // 原有布局（iPhone 和 iPad未订阅用户）
                        HStack {
                            if !storeManager.hasProVersion {
                                Text("🔒").font(.system(size: horizontalSizeClass == .regular ? 16 : 14))
                            }
                            Text(languageManager.localizedString("create_category"))
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(width: horizontalSizeClass == .regular ? 360 : (storeManager.hasProVersion ? 245 : 165), height: horizontalSizeClass == .regular ? 68 : 50)
                        .background(Color.green)
                        .cornerRadius(12)
                    }
                }
                
                if !storeManager.hasProVersion {
                    Button(action: { showPurchaseView = true }) {
                        HStack(spacing: horizontalSizeClass == .regular ? 8 : 6) {
                            Text("👑").font(.system(size: horizontalSizeClass == .regular ? 18 : 16))
                            Text(languageManager.localizedString("upgrade_to_pro"))
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: horizontalSizeClass == .regular ? 360 : 165, height: horizontalSizeClass == .regular ? 68 : 50)
                        .background(Color.orange)
                        .cornerRadius(12)
                    }
                }
            }
            
            // Edit hint for iPhone pro users
            if horizontalSizeClass != .regular && storeManager.hasProVersion {
                Text(languageManager.localizedString("edit_cards_hint"))
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            // Privacy policy button
            Button(action: { showPrivacyPolicy = true }) {
                Text(languageManager.localizedString("read_privacy"))
                    .font(.system(size: horizontalSizeClass == .regular ? 14 : 13))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, horizontalSizeClass == .regular ? 20 : 0)
        .padding(.top, 20)
        .padding(.bottom, horizontalSizeClass == .regular ? 40 : 0)
    }
    
    // NavigationLink组件
    private var navigationLinks: some View {
        Group {
            NavigationLink(
                destination: Group {
                    if let category = selectedCategory {
                        GameView(
                            category: category,
                            duration: selectedTime,
                            onGameEnd: {
                                navigateToGame = false
                                showTimeModal = false
                            }
                        )
                    }
                },
                isActive: $navigateToGame
            ) {
                EmptyView()
            }
            .hidden()
            
            NavigationLink(
                destination: Group {
                    if let customCat = selectedCustomCategory {
                        CustomGameView(
                            words: customCat.words,
                            duration: selectedTime,
                            onGameEnd: {
                                navigateToCustomGame = false
                                showTimeModal = false
                            }
                        )
                    }
                },
                isActive: $navigateToCustomGame
            ) {
                EmptyView()
            }
            .hidden()
        }
    }
    
    // Overlay内容
    private var overlayContent: some View {
        Group {
            if showTimeModal {
                    if let category = selectedCategory {
                        TimeSelectionView(
                            category: category,
                            selectedTime: $selectedTime,
                            timeOptions: timeOptions,
                            isPresented: $showTimeModal,
                            onStartGame: {
                                navigateToGame = true
                            }
                        )
                        .transition(AnyTransition.opacity)
                        .zIndex(1)
                    } else if let customCat = selectedCustomCategory {
                        CustomTimeSelectionView(
                            customCategory: customCat,
                            selectedTime: $selectedTime,
                            timeOptions: timeOptions,
                            isPresented: $showTimeModal,
                       onStartGame: {
                                navigateToCustomGame = true
                            }
                        )
                        .transition(AnyTransition.opacity)
                        .zIndex(1)
                    }
                }
                
                if showPrivacyPolicy {
                    PrivacyPolicyView(isPresented: $showPrivacyPolicy)
                        .transition(AnyTransition.opacity)
                        .zIndex(2)
                }
                
                if showPurchaseView {
                    PurchaseView(isPresented: $showPurchaseView)
                        .transition(AnyTransition.opacity)
                        .zIndex(3)
                }
                
                if showCustomCategory {
                    CustomCategoryView(isPresented: $showCustomCategory, toastManager: toastManager)
                        .transition(AnyTransition.opacity)
                        .zIndex(4)
                }
                
                if showRules {
                    GameRulesView(isPresented: $showRules)
                        .transition(AnyTransition.opacity)
                        .zIndex(6)
                }
                
                if showLanguageSelector {
                    LanguageSelectorView(isPresented: $showLanguageSelector)
                        .transition(AnyTransition.opacity)
                        .zIndex(5)
                }
                
                // Toast
                if toastManager.showToast {
                    VStack {
                        Spacer()
                        ToastView(message: toastManager.toastMessage)
                            .padding(.bottom, 100)
                    }
                    .transition(AnyTransition.move(edge: .bottom).combined(with: AnyTransition.opacity))
                    .zIndex(999)
                }
            }
        }
    }

struct CategoryCard: View {
    let category: GameCategory
    let isLocked: Bool
    let action: () -> Void
    @ObservedObject var languageManager: LanguageManager
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        Button(action: action) {
            ZStack {
                VStack(spacing: horizontalSizeClass == .regular ? 20 : 15) {
                    Text(category.icon)
                        .font(.system(size: horizontalSizeClass == .regular ? 60 : 50))
                        .opacity(isLocked ? 0.5 : 1.0)
                    
                    Text(category.localizedName(language: languageManager.currentLanguage))
                        .font(.system(size: horizontalSizeClass == .regular ? 18 : 18, weight: .semibold))
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                        .opacity(isLocked ? 0.5 : 1.0)
                        .shadow(radius: 0)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
                .frame(width: horizontalSizeClass == .regular ? 130 : 130) // iPad: 150 - 20 = 130
                .padding(.horizontal, horizontalSizeClass == .regular ? 20 : 15)
                .padding(.vertical, horizontalSizeClass == .regular ? 0 : 15) // iPhone: 上下左右相等间距
                .frame(height: horizontalSizeClass == .regular ? 170 : 140) // iPad: 180 - 10 = 170
                .background(Color.white)
                .cornerRadius(horizontalSizeClass == .regular ? 25 : 20)
                .overlay(
                    RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 25 : 20)
                        .stroke(Color(red: 0.0, green: 0.21, blue: 0.55), lineWidth: horizontalSizeClass == .regular ? 2 : 3) // iPad: 4 - 2 = 2
                )
                
                if isLocked {
                    VStack(spacing: 4) {
                        Text("🔒")
                            .font(.system(size: horizontalSizeClass == .regular ? 35 : 30))
                        Text(languageManager.localizedString("pro_version"))
                            .font(.system(size: horizontalSizeClass == .regular ? 14 : 12, weight: .bold))
                            .foregroundColor(.appPrimary)
                    }
                }
            }
        }
    }
}

// 自定义分类卡片
struct CustomCategoryCard: View {
    let category: CustomCategory
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var showEditMenu = false
    @State private var showEditModal = false
    @State private var showDeleteAlert = false
    @State private var editedName: String = ""
    @State private var editedWords: String = ""
    @ObservedObject var toastManager: ToastManager
    @ObservedObject var categoryManager = CustomCategoryManager.shared
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: horizontalSizeClass == .regular ? 20 : 15) {
                Text(category.icon)
                    .font(.system(size: horizontalSizeClass == .regular ? 60 : 40)) // iPhone: 50 * 0.8 = 40
                
                Text(category.name)
                    .font(.system(size: horizontalSizeClass == .regular ? 18 : 18, weight: .semibold))
                    .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 0)
            }
            .frame(width: horizontalSizeClass == .regular ? 130 : 130) // iPad: 150 - 20 = 130
            .padding(.horizontal, horizontalSizeClass == .regular ? 20 : 15)
            .frame(height: horizontalSizeClass == .regular ? 170 : 134) // iPad: 180 - 10 = 170
            .background(Color.white)
            .cornerRadius(horizontalSizeClass == .regular ? 25 : 20)
            .overlay(
                RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 25 : 20)
                    .stroke(Color(red: 0.7, green: 0.8, blue: 0.95), lineWidth: horizontalSizeClass == .regular ? 2 : 3) // iPad: 4 - 2 = 2
            )
            .offset(y: horizontalSizeClass == .regular ? 0 : 4) // iPhone: 往下移动4px
        }
        .onLongPressGesture {
            showEditMenu = true
        }
        .contextMenu {
            Button(action: {
                editedName = category.name
                editedWords = category.words.joined(separator: ",")
                showEditModal = true
            }) {
                Label("编辑", systemImage: "pencil")
            }
            
            Button(role: .destructive, action: {
                showDeleteAlert = true
            }) {
                Label("删除", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showEditModal) {
            EditCustomCategoryView(
                category: category,
                editedName: $editedName,
                editedWords: $editedWords,
                isPresented: $showEditModal,
                toastManager: toastManager
            )
        }
        .alert("删除分类", isPresented: $showDeleteAlert) {
            Button("取消", role: .cancel) { }
            Button("确定", role: .destructive) {
                categoryManager.deleteCategory(category)
                toastManager.show("删除成功")
            }
        } message: {
            Text("删除后将无法恢复，是否确定删除")
        }
    }
}

struct TimeSelectionView: View {
    let category: GameCategory
    @Binding var selectedTime: Int
    let timeOptions: [Int]
    @Binding var isPresented: Bool
    let onStartGame: () -> Void  // 添加回调
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text(languageManager.localizedString("select_time"))
                        .font(.system(size: horizontalSizeClass == .regular ? 26 : 22, weight: .bold))
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    
                    Text(category.localizedName(language: languageManager.currentLanguage))
                        .font(.system(size: horizontalSizeClass == .regular ? 18 : 16))
                        .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                }
                .padding(.top, 30)
                
                VStack(spacing: 12) {
                    ForEach(timeOptions, id: \.self) { time in
                        Button(action: {
                            selectedTime = time
                        }) {
                            Text("\(time)s")
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .medium))
                                .foregroundColor(selectedTime == time ? Color.green : Color.adaptiveTextPrimary(for: colorScheme)) // 选中文字改为绿色
                                .frame(maxWidth: .infinity)
                                .frame(height: horizontalSizeClass == .regular ? 60 : 50)
                                .background(Color.adaptiveCardBackground(for: colorScheme)) // 背景始终为卡片背景色
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedTime == time ? Color.green : Color.gray.opacity(0.3), lineWidth: 2) // 选中绿色边框，默认浅灰色边框
                                )
                        }
                    }
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 50 : 35)
                
                Button(action: {
                    isPresented = false
                    onStartGame()
                }) {
                    Text(languageManager.localizedString("start_game"))
                        .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: horizontalSizeClass == .regular ? 60 : 50)
                        .background(Color.green)
                        .cornerRadius(25)
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 50 : 35)
                .padding(.bottom, 44)
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 380)
            // 移除固定高度，改为自适应
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 30)
        }
    }
}

// 卡片网格视图组件 - 分离复杂逻辑以避免编译器超时
struct CardGridView: View {
    @ObservedObject var categoryManager: CustomCategoryManager  // 改为@ObservedObject
    let storeManager: StoreManager
    let languageManager: LanguageManager
    let toastManager: ToastManager
    let columns: [GridItem]
    let horizontalSizeClass: UserInterfaceSizeClass?
    @Binding var showPurchaseView: Bool
    @Binding var showTimeModal: Bool
    @Binding var selectedCategory: GameCategory?
    @Binding var selectedCustomCategory: CustomCategory?
    
    var body: some View {
        if horizontalSizeClass == .regular {
            // iPad版本
            iPadCardGrid
        } else {
            // iPhone版本
            iPhoneCardGrid
        }
    }
    
    private var iPadCardGrid: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 25) {
                cardContent
            }
            .padding(.horizontal, 50)
            .padding(.top, 40)
            .padding(.bottom, 40)
        }
        .background(Color.clear)
        .frame(maxHeight: .infinity)  // 允许扩展但不强制填满
    }
    
    private var iPhoneCardGrid: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    cardContent
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .padding(.bottom, 0)  // 进一步减少底部padding：60 → 0
            }
            .frame(height: geometry.size.height)  // 使用全部高度
        }
        .background(Color.clear)
    }
    
    private var cardContent: some View {
        Group {
            // 添加调试信息
            let _ = print("🎴 cardContent渲染 - 自定义分类数量: \(categoryManager.customCategories.count)")
            let _ = categoryManager.customCategories.forEach { category in
                print("🎴 - 自定义分类: \(category.name)")
            }
            
            ForEach(categoryManager.customCategories, id: \.id) { customCat in  // 添加id: \.id
                CustomCategoryCard(
                    category: customCat,
                    action: {
                        selectedCustomCategory = customCat
                        showTimeModal = true
                    },
                    toastManager: toastManager
                )
            }
            
            ForEach(GameCategory.allCases, id: \.self) { category in
                CategoryCard(
                    category: category,
                    isLocked: category.isPro && !storeManager.hasProVersion,
                    action: {
                        if category.isPro && !storeManager.hasProVersion {
                            showPurchaseView = true
                        } else {
                            selectedCategory = category
                            showTimeModal = true
                        }
                    },
                    languageManager: languageManager
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PrivacyPolicyView: View {
    @Binding var isPresented: Bool
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 0) {
                // 标题栏
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                    }
                    
                    Spacer()
                    
                    Text(languageManager.localizedString("privacy_policy_title"))
                        .font(.system(size: horizontalSizeClass == .regular ? 24 : 20, weight: .bold))
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    
                    Spacer()
                    
                    // 占位符保持对称
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.clear)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(Color.adaptiveCardBackground(for: colorScheme))
                
                // 内容区域
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(languageManager.localizedString("privacy_last_updated"))
                            .font(.system(size: 14))
                            .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(languageManager.localizedString("privacy_summary_title"))
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.appPrimary)
                            Text(languageManager.localizedString("privacy_summary_content"))
                                .font(.system(size: 15))
                                .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                                .padding(12)
                                .background(Color.appPrimary.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_1_title"),
                            content: languageManager.localizedString("privacy_section_1_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_2_title"),
                            content: languageManager.localizedString("privacy_section_2_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_3_title"),
                            content: languageManager.localizedString("privacy_section_3_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_4_title"),
                            content: languageManager.localizedString("privacy_section_4_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_5_title"),
                            content: languageManager.localizedString("privacy_section_5_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_6_title"),
                            content: languageManager.localizedString("privacy_section_6_content")
                        )
                        
                        privacySection(
                            title: languageManager.localizedString("privacy_section_7_title"),
                            content: languageManager.localizedString("privacy_section_7_content")
                        )
                        
                        Text(languageManager.localizedString("privacy_copyright"))
                            .font(.system(size: 12))
                            .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 20)
                    }
                    .padding(24)
                }
                .background(Color.adaptiveCardBackground(for: colorScheme))
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 700 : .infinity)
            .frame(maxHeight: horizontalSizeClass == .regular ? 800 : 700)
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 20)
            .padding(.vertical, horizontalSizeClass == .regular ? 60 : 40)
        }
    }
    
    private func privacySection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.appPrimary)
            
            Text(content)
                .font(.system(size: 15))
                .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                .lineSpacing(4)
        }
    }
}



// 自定义分类视图
struct CustomCategoryView: View {
    @Binding var isPresented: Bool
    @ObservedObject var toastManager: ToastManager
    @ObservedObject var categoryManager = CustomCategoryManager.shared  // 改为@ObservedObject
    @StateObject private var languageManager = LanguageManager.shared
    @State private var customWords: String = ""
    @State private var categoryName: String = ""
    @State private var selectedIcon: String = "⭐️"
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // 预设图标 - 14个图标支持手机端2行7列显示
    let availableIcons = ["⭐️", "🍎", "🐶", "🏠", "🚗", "⚽️", "🎵", "📚", "🎨", "🌟", "🔥", "💎", "🌈", "🎯"]
    
    var wordsArray: [String] {
        customWords
            .components(separatedBy: CharacterSet(charactersIn: ",，\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    var canSave: Bool {
        !categoryName.isEmpty && wordsArray.count >= 5
    }
    
    var body: some View {
        if horizontalSizeClass == .regular {
            // iPad 专用布局
            GeometryReader { geometry in
                ZStack {
                    // 背景图片
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // 固定顶部导航栏 - iPad
                        HStack {
                            // 关闭按钮
                            Button(action: {
                                isPresented = false
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white.opacity(0.9))
                                        .frame(width: 42, height: 42)
                                    
                                    Image(systemName: "xmark")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                                }
                            }
                            
                            Spacer()
                            
                            // 标题
                            Text(languageManager.localizedString("new_category"))
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // 保存按钮
                            Button(action: {
                                if canSave {
                                    saveCategory()
                                }
                            }) {
                                Text(languageManager.localizedString("save"))
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(canSave ? .white : Color.white.opacity(0.5))
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(canSave ? Color.green : Color.gray.opacity(0.3))
                                    )
                            }
                            .disabled(!canSave)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.4), Color.clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(height: 100)
                        
                        // 内容区域 - iPad
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                // 分类名称卡片
                                VStack(spacing: 16) {
                                    HStack {
                                        Text(languageManager.localizedString("category_name"))
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    
                                    TextField(languageManager.localizedString("category_name_placeholder"), text: $categoryName)
                                        .font(.system(size: 18))
                                        .padding(16)
                                        .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                                        .cornerRadius(12)
                                        .foregroundColor(.black)
                                }
                                .padding(30)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                
                                // 词汇输入卡片
                                VStack(spacing: 16) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(languageManager.localizedString("input_words"))
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.black)
                                            Text(languageManager.localizedString("input_words_hint"))
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                                        }
                                        Spacer()
                                        
                                        // 词汇数量指示器
                                        HStack(spacing: 6) {
                                            Image(systemName: wordsArray.count >= 5 ? "checkmark.circle.fill" : "info.circle.fill")
                                                .foregroundColor(wordsArray.count >= 5 ? .green : .orange)
                                                .font(.system(size: 18))
                                            Text("\(wordsArray.count)")
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(wordsArray.count >= 5 ? .green : .orange)
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill((wordsArray.count >= 5 ? Color.green : Color.orange).opacity(0.1))
                                        )
                                    }
                                    
                                    ZStack {
                                        // 灰色背景
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                        
                                        // 自定义TextEditor
                                        CustomTextEditor(text: $customWords)
                                            .padding(16)
                                    }
                                    .frame(height: 280)
                                }
                                .padding(30)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                                
                                // 选择封面图标
                                VStack(spacing: 16) {
                                    HStack {
                                        Text(languageManager.localizedString("select_icon"))
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    
                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 8), spacing: 12) {
                                        ForEach(availableIcons, id: \.self) { icon in
                                            Button(action: {
                                                selectedIcon = icon
                                            }) {
                                                Text(icon)
                                                    .font(.system(size: 32))
                                                    .frame(width: 60, height: 60)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .fill(selectedIcon == icon ? Color.green.opacity(0.15) : Color(red: 0.93, green: 0.93, blue: 0.93))
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .stroke(selectedIcon == icon ? Color.green : Color.clear, lineWidth: 2)
                                                            )
                                                    )
                                            }
                                        }
                                    }
                                }
                                .padding(30)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                )
                            }
                            .padding(.horizontal, 60)
                            .padding(.top, 20)
                            .padding(.bottom, 50)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        } else {
            // iPhone 原有布局保持不变
            ZStack {
                // 背景图片
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 固定顶部导航栏
                    HStack {
                        // 关闭按钮
                        Button(action: {
                            isPresented = false
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.9))
                                    .frame(width: 36, height: 36)
                                
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            }
                        }
                        
                        Spacer()
                        
                        // 标题
                        Text(languageManager.localizedString("new_category"))
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // 保存按钮
                        Button(action: {
                            if canSave {
                                saveCategory()
                            }
                        }) {
                            Text(languageManager.localizedString("save"))
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(canSave ? .white : Color.white.opacity(0.5))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(canSave ? Color.green : Color.gray.opacity(0.3))
                                )
                        }
                        .disabled(!canSave)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    // 内容区域
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 14) {
                            // 分类名称卡片
                            VStack(spacing: 16) {
                                HStack {
                                    Text(languageManager.localizedString("category_name"))
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                TextField(languageManager.localizedString("category_name_placeholder"), text: $categoryName)
                                    .font(.system(size: 16))
                                    .padding(16)
                                    .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                                    .cornerRadius(12)
                                    .foregroundColor(.black)
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                            
                            // 词汇输入卡片
                            VStack(spacing: 16) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(languageManager.localizedString("input_words"))
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(.black)
                                        Text(languageManager.localizedString("input_words_hint"))
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                                    }
                                    Spacer()
                                    
                                    // 词汇数量指示器
                                    HStack(spacing: 6) {
                                        Image(systemName: wordsArray.count >= 5 ? "checkmark.circle.fill" : "info.circle.fill")
                                            .foregroundColor(wordsArray.count >= 5 ? .green : .orange)
                                            .font(.system(size: 16))
                                        Text("\(wordsArray.count)")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(wordsArray.count >= 5 ? .green : .orange)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill((wordsArray.count >= 5 ? Color.green : Color.orange).opacity(0.1))
                                    )
                                }
                                
                                ZStack {
                                    // 灰色背景
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                    
                                    // 自定义TextEditor
                                    CustomTextEditor(text: $customWords)
                                        .padding(16)
                                }
                                .frame(height: 220)
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                            
                            // 选择封面图标
                            VStack(spacing: 16) {
                                HStack {
                                    Text("选择封面图标")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 7), spacing: 12) {
                                    ForEach(availableIcons, id: \.self) { icon in
                                        Button(action: {
                                            selectedIcon = icon
                                        }) {
                                            Text(icon)
                                                .font(.system(size: 24))
                                                .frame(width: 42, height: 42)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedIcon == icon ? Color.green.opacity(0.15) : Color(red: 0.93, green: 0.93, blue: 0.93))
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(selectedIcon == icon ? Color.green : Color.clear, lineWidth: 2)
                                                        )
                                                )
                                        }
                                    }
                                }
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
    }
    
    private func saveCategory() {
        print("💾 保存分类")
        print("💾 分类名称: \(categoryName)")
        print("💾 词汇数量: \(wordsArray.count)")
        print("💾 词汇列表: \(wordsArray)")
        
        let category = CustomCategory(
            name: categoryName,
            words: wordsArray,
            icon: selectedIcon
        )
        
        // 保存分类
        categoryManager.addCategory(category)
        
        // 显示Toast提示
        toastManager.show(languageManager.localizedString("creation_success"))
        
        // 延迟关闭弹窗，确保UI更新完成
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isPresented = false
        }
    }
}

// 编辑自定义分类视图
struct EditCustomCategoryView: View {
    let category: CustomCategory
    @Binding var editedName: String
    @Binding var editedWords: String
    @Binding var isPresented: Bool
    @ObservedObject var toastManager: ToastManager
    @ObservedObject var categoryManager = CustomCategoryManager.shared  // 改为@ObservedObject
    @State private var selectedIcon: String = ""
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    let availableIcons = ["⭐️", "🍎", "🐶", "🏠", "🚗", "⚽️", "🎵", "📚", "🎨", "🌟", "🔥", "💎", "🌈", "🎯"]
    
    var wordsArray: [String] {
        editedWords
            .components(separatedBy: CharacterSet(charactersIn: ",，\n"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    var canSave: Bool {
        !editedName.isEmpty && wordsArray.count >= 5
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("编辑")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            saveChanges()
                        }) {
                            Text("保存")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(canSave ? .white : Color.white.opacity(0.5))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(canSave ? Color.green : Color.gray.opacity(0.3))
                                )
                        }
                        .disabled(!canSave)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                    
                    ScrollView {
                        VStack(spacing: 14) {
                            VStack(spacing: 16) {
                                HStack {
                                    Text("分类名称")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                TextField("分类名称", text: $editedName)
                                    .font(.system(size: 16))
                                    .padding(16)
                                    .background(Color(red: 0.93, green: 0.93, blue: 0.93))
                                    .cornerRadius(12)
                                    .foregroundColor(.black)
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Text("输入词汇")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(red: 0.93, green: 0.93, blue: 0.93))
                                    
                                    CustomTextEditor(text: $editedWords)
                                        .padding(16)
                                }
                                .frame(height: 220)
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                            
                            // 选择封面图标
                            VStack(spacing: 16) {
                                HStack {
                                    Text("选择封面图标")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 7), spacing: 12) { // 改为7列
                                    ForEach(availableIcons, id: \.self) { icon in
                                        Button(action: {
                                            selectedIcon = icon
                                        }) {
                                            Text(icon)
                                                .font(.system(size: 24)) // 稍小适应7列
                                                .frame(width: 42, height: 42) // 稍小适应7列
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedIcon == icon ? Color.green.opacity(0.15) : Color(red: 0.93, green: 0.93, blue: 0.93))
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(selectedIcon == icon ? Color.green : Color.clear, lineWidth: 2)
                                                        )
                                                )
                                        }
                                    }
                                }
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                            )
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                selectedIcon = category.icon
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func saveChanges() {
        categoryManager.updateCategory(category, name: editedName, words: wordsArray, icon: selectedIcon)
        toastManager.show("内容已修改")
        isPresented = false
    }
}

// 自定义分类时间选择视图
struct CustomTimeSelectionView: View {
    let customCategory: CustomCategory
    @Binding var selectedTime: Int
    let timeOptions: [Int]
    @Binding var isPresented: Bool
    let onStartGame: () -> Void  // 添加回调
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(customCategory: CustomCategory, selectedTime: Binding<Int>, timeOptions: [Int], isPresented: Binding<Bool>, onStartGame: @escaping () -> Void) {
        self.customCategory = customCategory
        self._selectedTime = selectedTime
        self.timeOptions = timeOptions
        self._isPresented = isPresented
        self.onStartGame = onStartGame
        print("⏰ CustomTimeSelectionView初始化")
        print("⏰ 分类名称: \(customCategory.name)")
        print("⏰ 词汇数量: \(customCategory.words.count)")
        print("⏰ 词汇列表: \(customCategory.words)")
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Text(languageManager.localizedString("select_time"))
                        .font(.system(size: horizontalSizeClass == .regular ? 26 : 22, weight: .bold))
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    
                    Text(customCategory.name)
                        .font(.system(size: horizontalSizeClass == .regular ? 18 : 16))
                        .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                }
                .padding(.top, 30)
                
                VStack(spacing: 12) {
                    ForEach(timeOptions, id: \.self) { time in
                        Button(action: {
                            selectedTime = time
                        }) {
                            Text("\(time)s")
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .medium))
                                .foregroundColor(selectedTime == time ? Color.green : Color.adaptiveTextPrimary(for: colorScheme)) // 选中文字改为绿色
                                .frame(maxWidth: .infinity)
                                .frame(height: horizontalSizeClass == .regular ? 60 : 50)
                                .background(Color.adaptiveCardBackground(for: colorScheme)) // 背景始终为卡片背景色
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedTime == time ? Color.green : Color.gray.opacity(0.3), lineWidth: 2) // 选中绿色边框，默认浅灰色边框
                                )
                        }
                    }
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 50 : 35)
                
                Button(action: {
                    isPresented = false
                    onStartGame()
                }) {
                    Text(languageManager.localizedString("start_game"))
                        .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: horizontalSizeClass == .regular ? 60 : 50)
                        .background(Color.green)
                        .cornerRadius(25)
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 50 : 35)
                .padding(.bottom, 44)
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 380)
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 30)
        }
    }
}

// 自定义游戏视图（复用GameView的逻辑）
struct CustomGameView: View {
    let words: [String]
    let duration: Int
    let onGameEnd: () -> Void
    
    @StateObject private var viewModel: CustomGameViewModel
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var showExitAlert = false
    
    init(words: [String], duration: Int, onGameEnd: @escaping () -> Void) {
        self.words = words
        self.duration = duration
        self.onGameEnd = onGameEnd
        print("🎮 CustomGameView初始化 - 词汇数量: \(words.count)")
        print("🎮 词汇列表: \(words)")
        _viewModel = StateObject(wrappedValue: CustomGameViewModel(words: words, duration: duration))
    }
    
    var body: some View {
        ZStack {
            // 背景图片
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 顶部信息栏 - 关闭按钮和得分区域
                HStack {
                    // 左上角关闭按钮
                    Button(action: {
                        showExitAlert = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.adaptiveCardBackground(for: colorScheme))
                                .frame(width: horizontalSizeClass == .regular ? 50 : 40, height: horizontalSizeClass == .regular ? 50 : 40)
                            
                            Image(systemName: "xmark")
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .semibold))
                                .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        }
                    }
                    
                    Spacer()
                    
                    // 右上角得分 - 横向排列
                    HStack(spacing: horizontalSizeClass == .regular ? 8 : 6) {
                        Text(languageManager.localizedString("correct") + ":")
                            .font(.system(size: horizontalSizeClass == .regular ? 18 : 15, weight: .medium))
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        Text("\(viewModel.score)")
                            .font(.system(size: horizontalSizeClass == .regular ? 28 : 22, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 20 : 16)
                    .padding(.vertical, horizontalSizeClass == .regular ? 12 : 10)
                    .background(
                        RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 16 : 14)
                            .fill(Color.white)
                    )
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
                .padding(.top, horizontalSizeClass == .regular ? 60 : 40)
                .padding(.bottom, horizontalSizeClass == .regular ? 30 : 20)
                
                // 倒计时 - 放在进度条上方
                Text("\(viewModel.countdown)s")
                    .font(.system(size: horizontalSizeClass == .regular ? 48 : 32, weight: .bold))
                    .foregroundColor(viewModel.countdown <= 10 ? .red : .orange)
                    .padding(.bottom, horizontalSizeClass == .regular ? 20 : 20)
                
                    // 进度条
                    ZStack {
                        // 进度条背景
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.3))
                            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 280)
                            .frame(height: horizontalSizeClass == .regular ? 12 : 8)
                        
                        // 进度条前景
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(viewModel.countdown <= 10 ? Color.red : Color.white)
                                .frame(width: geometry.size.width * viewModel.progress)
                                .frame(height: horizontalSizeClass == .regular ? 12 : 8)
                        }
                        .frame(maxWidth: horizontalSizeClass == .regular ? 500 : 280)
                        .frame(height: horizontalSizeClass == .regular ? 12 : 8)
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 35)
                    .padding(.bottom, horizontalSizeClass == .regular ? 40 : 30)
                    
                    // 词汇卡片
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 6)
                        
                        Text(viewModel.currentWord)
                            .font(.system(size: horizontalSizeClass == .regular ? 56 : 36, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(horizontalSizeClass == .regular ? 50 : 30)
                    }
                    .frame(height: horizontalSizeClass == .regular ? 300 : 360)
                    .frame(maxWidth: horizontalSizeClass == .regular ? 700 : .infinity)
                    .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 30)
                    .padding(.top, horizontalSizeClass == .regular ? 60 : 40)
                    .padding(.bottom, horizontalSizeClass == .regular ? 60 : 40)
                
                // 操作按钮
                HStack(spacing: horizontalSizeClass == .regular ? 50 : 40) {
                    // 答对按钮
                    GameActionButton(
                        symbol: "✓",
                        text: languageManager.localizedString("correct"),
                        color: .green,
                        horizontalSizeClass: horizontalSizeClass,
                        action: { viewModel.correctAnswer() }
                    )
                    
                    // 跳过按钮
                    GameActionButton(
                        symbol: "→",
                        text: languageManager.localizedString("skip"),
                        color: .orange,
                        horizontalSizeClass: horizontalSizeClass,
                        action: { viewModel.skipWord() }
                    )
                }
                .padding(.bottom, horizontalSizeClass == .regular ? 80 : 80)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.startGame()
        }
        .onDisappear {
            viewModel.pauseGame()
        }
        .overlay(
            Group {
                if showExitAlert {
                    GameExitConfirmView(
                        onConfirm: {
                            viewModel.endGame()
                            onGameEnd()
                            presentationMode.wrappedValue.dismiss()
                        },
                        onCancel: {
                            showExitAlert = false
                        }
                    )
                    .transition(AnyTransition.opacity)
                    .zIndex(999)
                }
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: showExitAlert)
        .overlay(
            Group {
                if viewModel.isGameOver {
                    GameOverView(score: viewModel.score) {
                        onGameEnd()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .transition(AnyTransition.opacity)
                    .zIndex(999)
                }
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.isGameOver)
    }
}

// 自定义游戏ViewModel
class CustomGameViewModel: ObservableObject {
    @Published var currentWord: String = ""
    @Published var countdown: Int
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    @Published var progress: Double = 1.0
    
    private var wordList: [String]
    private var usedWords: Set<String> = []
    private var timer: Timer?
    private let totalDuration: Int
    
    init(words: [String], duration: Int) {
        print("🎯 CustomGameViewModel初始化 - 词汇数量: \(words.count)")
        print("🎯 词汇列表: \(words)")
        self.wordList = words
        self.totalDuration = duration
        self.countdown = duration
        getRandomWord()
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.countdown > 0 {
                self.countdown -= 1
                self.progress = Double(self.countdown) / Double(self.totalDuration)
            } else {
                self.endGame()
            }
        }
    }
    
    func getRandomWord() {
        let availableWords = wordList.filter { !usedWords.contains($0) }
        
        if availableWords.isEmpty {
            usedWords.removeAll()
        }
        
        let wordsToUse = availableWords.isEmpty ? wordList : availableWords
        
        if let randomWord = wordsToUse.randomElement() {
            currentWord = randomWord
            usedWords.insert(randomWord)
        }
    }
    
    func correctAnswer() {
        let generator = UIKit.UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        score += 1
        getRandomWord()
    }
    
    func skipWord() {
        let generator = UIKit.UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        getRandomWord()
    }
    
    func endGame() {
        timer?.invalidate()
        timer = nil
        isGameOver = true
    }
    
    func pauseGame() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        timer?.invalidate()
    }
}


// 语言选择器视图
struct LanguageSelectorView: View {
    @Binding var isPresented: Bool
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack {
            Color.adaptiveOverlay(for: colorScheme)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 0) {
                // 标题栏
                HStack {
                    Text("🌐 Language / 语言")
                        .font(.system(size: horizontalSizeClass == .regular ? 24 : 20, weight: .bold))
                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                    
                    Spacer()
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.adaptiveTextSecondary(for: colorScheme))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(Color.adaptiveCardBackground(for: colorScheme))
                
                // 语言列表
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(AppLanguage.allCases) { language in
                            Button(action: {
                                languageManager.currentLanguage = language
                                // 延迟关闭，让用户看到选择效果
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    isPresented = false
                                }
                            }) {
                                HStack(spacing: 15) {
                                    Text(language.flag)
                                        .font(.system(size: 32))
                                    
                                    Text(language.displayName)
                                        .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .medium))
                                        .foregroundColor(Color.adaptiveTextPrimary(for: colorScheme))
                                    
                                    Spacer()
                                    
                                    if languageManager.currentLanguage == language {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.appPrimary)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(
                                    languageManager.currentLanguage == language
                                        ? Color.appPrimary.opacity(0.1)
                                        : Color.adaptiveCardBackground(for: colorScheme)
                                )
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            languageManager.currentLanguage == language
                                                ? Color.appPrimary
                                                : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                            }
                        }
                    }
                    .padding(20)
                }
                .background(Color.adaptiveCardBackground(for: colorScheme))
            }
            .frame(maxWidth: horizontalSizeClass == .regular ? 500 : .infinity)
            .frame(maxHeight: horizontalSizeClass == .regular ? 700 : 600)
            .background(Color.adaptiveCardBackground(for: colorScheme))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 20)
            .padding(.vertical, horizontalSizeClass == .regular ? 60 : 40)
        }
    }
}
// MARK: - PurchaseView
struct PurchaseView: View {
    @Binding var isPresented: Bool
    @StateObject private var storeManager = StoreManager.shared
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedPlan = 2 // 默认选择年订阅
    
    var plans: [(String, String, String?)] {
        [
            (languageManager.localizedString("weekly"), "$1.99 / week", languageManager.localizedString("3_day_free_trial")),
            (languageManager.localizedString("monthly"), "$3.99 / month", nil),
            (languageManager.localizedString("yearly"), "$19.99 / year", languageManager.localizedString("best_value")),
            (languageManager.localizedString("lifetime"), "$24.99", languageManager.localizedString("one_time_pay"))
        ]
    }
    
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
                // 主要内容
                ScrollView(showsIndicators: false) {
                    VStack(spacing: horizontalSizeClass == .regular ? 32 : 24) {
                        // 标题
                        titleSection
                        
                        // 功能列表
                        benefitsSection
                        
                        // 定价方案
                        pricingSection
                        
                        // 订阅按钮
                        subscribeButton
                        
                        // 条款
                        termsSection
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
                    .padding(.top, horizontalSizeClass == .regular ? 120 : 100) // 为顶部按钮留出空间
                    .padding(.bottom, 40)
                }
            }
            
            // 顶部关闭按钮 - 使用ZStack覆盖在内容上方
            VStack {
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
                .padding(.top, horizontalSizeClass == .regular ? 20 : 16)
                .padding(.bottom, 20)
                .background(
                    // 添加渐变背景，从不透明到透明
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color(red: 0.1, green: 0.1, blue: 0.2).opacity(0.95), location: 0.0),
                            .init(color: Color(red: 0.1, green: 0.1, blue: 0.2).opacity(0.8), location: 0.7),
                            .init(color: Color.clear, location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                Spacer()
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
        .alert("错误", isPresented: .constant(storeManager.errorMessage != nil)) {
            Button("确定") {
                storeManager.errorMessage = nil
            }
        } message: {
            if let errorMessage = storeManager.errorMessage {
                Text(errorMessage)
            }
        }
        .alert("购买成功", isPresented: $storeManager.purchaseSuccess) {
            Button("确定") {
                storeManager.purchaseSuccess = false
                isPresented = false
            }
        } message: {
            Text("感谢您的购买！专业版功能已解锁。")
        }
        .alert("恢复成功", isPresented: $storeManager.restoreSuccess) {
            Button("确定") {
                storeManager.restoreSuccess = false
                isPresented = false
            }
        } message: {
            Text("您的购买已成功恢复！")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: horizontalSizeClass == .regular ? 16 : 12) {
            Text(languageManager.localizedString("premium_unlock"))
                .font(.system(size: horizontalSizeClass == .regular ? 36 : 28, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text(languageManager.localizedString("choose_your_plan"))
                .font(.system(size: horizontalSizeClass == .regular ? 20 : 16, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
    }
    
    private var pricingSection: some View {
        VStack(spacing: 12) {
            ForEach(0..<plans.count, id: \.self) { index in
                pricingCard(index: index)
            }
        }
    }
    
    private func pricingCard(index: Int) -> some View {
        let plan = plans[index]
        let isSelected = selectedPlan == index
        
        return Button(action: { selectedPlan = index }) {
            VStack(spacing: 0) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            if index == 2 {
                                Text("🔥")
                                    .font(.system(size: horizontalSizeClass == .regular ? 20 : 18))
                            }
                            
                            Text(plan.0)
                                .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            if let badge = plan.2 {
                                Text(badge)
                                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10, weight: .bold))
                                    .foregroundColor(index == 2 ? .orange : .green)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill((index == 2 ? Color.orange : Color.green).opacity(0.2))
                                    )
                            }
                        }
                        
                        Text(plan.1)
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
        .buttonStyle(PlainButtonStyle())
    }
    
    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: horizontalSizeClass == .regular ? 16 : 12) {
            Text(languageManager.localizedString("what_you_get"))
                .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                .foregroundColor(.white)
            
            VStack(alignment: .leading, spacing: horizontalSizeClass == .regular ? 12 : 8) {
                benefitRow(languageManager.localizedString("all_categories_unlocked"))
                benefitRow(languageManager.localizedString("no_ads"))
                benefitRow(languageManager.localizedString("custom_words_categories"))
                benefitRow(languageManager.localizedString("free_lifetime_updates"))
            }
            .padding(horizontalSizeClass == .regular ? 20 : 16)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.7, blue: 0.2).opacity(0.15),
                        Color(red: 1.0, green: 0.5, blue: 0.0).opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func benefitRow(_ text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "star.fill")
                .font(.system(size: horizontalSizeClass == .regular ? 16 : 14))
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.8, blue: 0.2),
                            Color(red: 1.0, green: 0.5, blue: 0.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text(text)
                .font(.system(size: horizontalSizeClass == .regular ? 16 : 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
    
    private var subscribeButton: some View {
        Button(action: purchaseSelectedPlan) {
            HStack {
                if storeManager.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Text(languageManager.localizedString("subscribe_now"))
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
    }
    
    private var termsSection: some View {
        VStack(spacing: 8) {
            Text(languageManager.localizedString("terms_apply"))
                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                Button(languageManager.localizedString("privacy_policy")) { }
                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                    .foregroundColor(.white.opacity(0.8))
                
                Button(languageManager.localizedString("terms_of_use")) { }
                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                    .foregroundColor(.white.opacity(0.8))
                
                Button(languageManager.localizedString("restore")) { restorePurchases() }
                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
    
    private func purchaseSelectedPlan() {
        Task {
            do {
                // 获取选中的产品
                let selectedProductID = getSelectedProductID()
                guard let product = storeManager.getProduct(for: selectedProductID) else {
                    await MainActor.run {
                        storeManager.errorMessage = "产品未找到，请稍后重试"
                    }
                    return
                }
                
                // 执行购买
                let transaction = try await storeManager.purchase(product)
                
                if transaction != nil {
                    // 购买成功，关闭界面
                    await MainActor.run {
                        isPresented = false
                    }
                }
                
            } catch {
                // 购买失败，错误信息已在StoreManager中处理
                print("购买失败: \(error)")
            }
        }
    }
    
    private func restorePurchases() {
        Task {
            await storeManager.restorePurchases()
            
            // 如果恢复成功，关闭界面
            if storeManager.restoreSuccess {
                await MainActor.run {
                    isPresented = false
                }
            }
        }
    }
    
    /// 获取当前选中的产品ID
    private func getSelectedProductID() -> ProductID {
        switch selectedPlan {
        case 0: return .weeklySubscription
        case 1: return .monthlySubscription
        case 2: return .yearlySubscription
        case 3: return .lifetimeSubscription
        default: return .yearlySubscription
        }
    }
}

// MARK: - GameActionButton
struct GameActionButton: View {
    let symbol: String
    let text: String
    let color: Color
    let horizontalSizeClass: UserInterfaceSizeClass?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: horizontalSizeClass == .regular ? 12 : 12) {
                Text(symbol)
                    .font(.system(size: horizontalSizeClass == .regular ? 50 : 45, weight: .bold))
                    .foregroundColor(.white)
                Text(text)
                    .font(.system(size: horizontalSizeClass == .regular ? 16 : 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: horizontalSizeClass == .regular ? 140 : 130, height: horizontalSizeClass == .regular ? 140 : 130)
            .background(color)
            .cornerRadius(horizontalSizeClass == .regular ? 20 : 20)
            .shadow(color: color.opacity(0.3), radius: horizontalSizeClass == .regular ? 10 : 8, x: 0, y: horizontalSizeClass == .regular ? 5 : 4)
        }
    }
}
