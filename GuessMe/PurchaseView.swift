import SwiftUI
import StoreKit

struct PurchaseView: View {
    @Binding var isPresented: Bool
    @StateObject private var storeManager = StoreManager.shared
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isLoading = false
    
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
                            pricingCard(title: "Weekly", price: "$1.99 / week", badge: "3-day free trial", isSelected: false)
                            pricingCard(title: "Monthly", price: "$3.99 / month", badge: nil, isSelected: false)
                            pricingCard(title: "Yearly", price: "$19.99 / year", badge: "BEST VALUE", isSelected: true)
                            pricingCard(title: "Lifetime", price: "$24.99", badge: "ONE-TIME PAY", isSelected: false)
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
                                if isLoading {
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
                        .disabled(isLoading)
                        
                        // 条款和链接
                        VStack(spacing: 8) {
                            Text("Terms apply. Subscription automatically renews unless cancelled.")
                                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                                .foregroundColor(.white.opacity(0.6))
                                .multilineTextAlignment(.center)
                            
                            HStack(spacing: 20) {
                                Button("Privacy Policy") { }
                                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                                    .foregroundColor(.white.opacity(0.8))
                                    .underline()
                                
                                Button("Terms of Use") { }
                                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                                    .foregroundColor(.white.opacity(0.8))
                                    .underline()
                                
                                Button("Restore") { restorePurchases() }
                                    .font(.system(size: horizontalSizeClass == .regular ? 12 : 10))
                                    .foregroundColor(.white.opacity(0.8))
                                    .underline()
                            }
                        }
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
                    .padding(.bottom, 40)
                }
            }
        }
    }
    
    private func pricingCard(title: String, price: String, badge: String?, isSelected: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(title)
                            .font(.system(size: horizontalSizeClass == .regular ? 20 : 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        if let badge = badge {
                            Text(badge)
                                .font(.system(size: horizontalSizeClass == .regular ? 12 : 10, weight: .bold))
                                .foregroundColor(title == "Yearly" ? .orange : .green)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill((title == "Yearly" ? Color.orange : Color.green).opacity(0.2))
                                )
                        }
                    }
                    
                    Text(price)
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
            
            if title == "Yearly" {
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
            } else if title == "Lifetime" {
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
    
    private func purchaseSelectedPlan() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            storeManager.hasProVersion = true
            isPresented = false
        }
    }
    
    private func restorePurchases() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(isPresented: .constant(true))
    }
}