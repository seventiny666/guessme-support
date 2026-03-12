import SwiftUI

extension Color {
    // 主题色 - 保持橙色
    static let appPrimary = Color(red: 1.0, green: 0.48, blue: 0.27)
    
    // 新增：蓝色渐变背景色
    static let appBlueGradientStart = Color(red: 0.2, green: 0.5, blue: 1.0)
    static let appBlueGradientEnd = Color(red: 0.1, green: 0.3, blue: 0.8)
    
    // 新增：绿色按钮渐变
    static let appGreenGradientStart = Color(red: 0.2, green: 0.8, blue: 0.6)
    static let appGreenGradientEnd = Color(red: 0.1, green: 0.7, blue: 0.5)
    
    // 新增：橙色按钮渐变
    static let appOrangeGradientStart = Color(red: 1.0, green: 0.6, blue: 0.2)
    static let appOrangeGradientEnd = Color(red: 0.9, green: 0.5, blue: 0.1)
    
    // 背景色
    static let appBackground = Color("AppBackground")
    
    // 卡片背景 - 纯白色
    static let appCardBackground = Color.white
    
    // 主要文字颜色
    static let appTextPrimary = Color("AppTextPrimary")
    
    // 次要文字颜色
    static let appTextSecondary = Color("AppTextSecondary")
    
    // 弹窗遮罩
    static let appOverlay = Color("AppOverlay")
}

// 新的蓝色渐变背景
extension Color {
    static func blueGradientBackground() -> LinearGradient {
        LinearGradient(
            colors: [appBlueGradientStart, appBlueGradientEnd],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static func greenButtonGradient() -> LinearGradient {
        LinearGradient(
            colors: [appGreenGradientStart, appGreenGradientEnd],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static func orangeButtonGradient() -> LinearGradient {
        LinearGradient(
            colors: [appOrangeGradientStart, appOrangeGradientEnd],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

// 适配不同模式的颜色（保持兼容性）
extension Color {
    static func adaptiveBackground(for colorScheme: ColorScheme) -> Color {
        // 始终使用蓝色渐变背景
        return appBlueGradientStart
    }
    
    static func adaptiveCardBackground(for colorScheme: ColorScheme) -> Color {
        // 始终使用白色卡片背景
        return Color.white
    }
    
    static func adaptiveTextPrimary(for colorScheme: ColorScheme) -> Color {
        // 卡片内文字使用深色
        return Color.black
    }
    
    static func adaptiveTextSecondary(for colorScheme: ColorScheme) -> Color {
        // 次要文字使用灰色
        return Color.gray
    }
    
    static func adaptiveOverlay(for colorScheme: ColorScheme) -> Color {
        return Color.black.opacity(0.6)
    }
}
