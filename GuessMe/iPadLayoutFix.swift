import SwiftUI

// iPad布局适配扩展
extension View {
    /// iPad专用的安全间距
    func iPadSafePadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil, horizontalSizeClass: UserInterfaceSizeClass?) -> some View {
        let isIPad = horizontalSizeClass == .regular
        let defaultPadding: CGFloat = isIPad ? 60 : 25
        return self.padding(edges, length ?? defaultPadding)
    }
    
    /// iPad专用的frame设置
    func iPadFrame(width: CGFloat? = nil, height: CGFloat? = nil, iPadWidth: CGFloat? = nil, iPadHeight: CGFloat? = nil, horizontalSizeClass: UserInterfaceSizeClass?) -> some View {
        let isIPad = horizontalSizeClass == .regular
        return self.frame(
            width: isIPad ? (iPadWidth ?? width) : width,
            height: isIPad ? (iPadHeight ?? height) : height
        )
    }
}

// iPad布局常量
struct iPadLayout {
    // 首页布局
    struct Home {
        static let titleTopPadding: CGFloat = 60
        static let titleBottomPadding: CGFloat = 20
        static let gridTopPadding: CGFloat = 10
        static let gridBottomPadding: CGFloat = 180
        static let gridHorizontalPadding: CGFloat = 60
        static let gridSpacing: CGFloat = 20
        static let columns: Int = 5
        
        // 卡片尺寸
        static let cardWidth: CGFloat = 120
        static let cardHeight: CGFloat = 140
        static let cardPadding: CGFloat = 15
        static let iconSize: CGFloat = 50
        static let textSize: CGFloat = 16
    }
    
    // 游戏页面布局
    struct Game {
        static let topPadding: CGFloat = 60
        static let bottomPadding: CGFloat = 80
        static let horizontalPadding: CGFloat = 60
        
        // 词汇卡片
        static let cardHeight: CGFloat = 300
        static let cardMaxWidth: CGFloat = 700
        static let cardPadding: CGFloat = 40
        static let wordFontSize: CGFloat = 48
        
        // 按钮
        static let buttonSize: CGFloat = 140
        static let buttonSpacing: CGFloat = 50
        static let buttonIconSize: CGFloat = 50
        static let buttonTextSize: CGFloat = 16
        
        // 进度条
        static let progressBarWidth: CGFloat = 600
        static let progressBarHeight: CGFloat = 12
        
        // 倒计时
        static let countdownFontSize: CGFloat = 42
        static let countdownBottomPadding: CGFloat = 15
    }
}

// iPhone布局常量
struct iPhoneLayout {
    // 首页布局
    struct Home {
        static let titleTopPadding: CGFloat = 50
        static let titleBottomPadding: CGFloat = 15
        static let gridTopPadding: CGFloat = 8
        static let gridBottomPadding: CGFloat = 160
        static let gridHorizontalPadding: CGFloat = 25
        static let gridSpacing: CGFloat = 20
        static let columns: Int = 2
        
        // 卡片尺寸
        static let cardWidth: CGFloat = 130
        static let cardHeight: CGFloat = 140
        static let cardPadding: CGFloat = 15
        static let iconSize: CGFloat = 50
        static let textSize: CGFloat = 18
    }
    
    // 游戏页面布局
    struct Game {
        static let topPadding: CGFloat = 50
        static let bottomPadding: CGFloat = 80
        static let horizontalPadding: CGFloat = 30
        
        // 词汇卡片
        static let cardHeight: CGFloat = 360
        static let cardPadding: CGFloat = 35
        static let wordFontSize: CGFloat = 42
        
        // 按钮
        static let buttonSize: CGFloat = 130
        static let buttonSpacing: CGFloat = 40
        static let buttonIconSize: CGFloat = 45
        static let buttonTextSize: CGFloat = 16
        
        // 进度条
        static let progressBarWidth: CGFloat = 300
        static let progressBarHeight: CGFloat = 10
        
        // 倒计时
        static let countdownFontSize: CGFloat = 36
        static let countdownBottomPadding: CGFloat = 15
    }
}
