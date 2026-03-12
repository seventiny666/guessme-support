import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    @StateObject private var languageManager = LanguageManager.shared
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var showExitAlert = false
    @State private var showResultAlert = false
    let onGameEnd: () -> Void
    
    init(category: GameCategory, duration: Int, onGameEnd: @escaping () -> Void = {}) {
        _viewModel = StateObject(wrappedValue: GameViewModel(category: category, duration: duration))
        self.onGameEnd = onGameEnd
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
                    HStack(spacing: horizontalSizeClass == .regular ? 12 : 6) {
                        Text(languageManager.localizedString("correct") + ":")
                            .font(.system(size: horizontalSizeClass == .regular ? 32 : 15, weight: .medium))
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                        Text("\(viewModel.score)")
                            .font(.system(size: horizontalSizeClass == .regular ? 52 : 22, weight: .bold))
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal, horizontalSizeClass == .regular ? 30 : 16)
                    .padding(.vertical, horizontalSizeClass == .regular ? 18 : 10)
                    .background(
                        RoundedRectangle(cornerRadius: horizontalSizeClass == .regular ? 20 : 14)
                            .fill(Color.white)
                    )
                }
                .padding(.horizontal, horizontalSizeClass == .regular ? 40 : 20)
                .padding(.top, horizontalSizeClass == .regular ? 40 : 40)
                .padding(.bottom, horizontalSizeClass == .regular ? 20 : 20)
                
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
                    .frame(height: horizontalSizeClass == .regular ? 500 : 360)
                    .frame(maxWidth: horizontalSizeClass == .regular ? 700 : .infinity)
                    .padding(.horizontal, horizontalSizeClass == .regular ? 60 : 30)
                    .padding(.top, horizontalSizeClass == .regular ? 60 : 40)
                    .padding(.bottom, horizontalSizeClass == .regular ? 80 : 40)
                
                // 操作按钮
                HStack(spacing: horizontalSizeClass == .regular ? 120 : 40) {
                    // 答对按钮
                    Button(action: {
                        viewModel.correctAnswer()
                    }) {
                        VStack(spacing: horizontalSizeClass == .regular ? 16 : 12) {
                            Text("✓")
                                .font(.system(size: horizontalSizeClass == .regular ? 70 : 45, weight: .bold))
                                .foregroundColor(.white)
                            Text(languageManager.localizedString("correct"))
                                .font(.system(size: horizontalSizeClass == .regular ? 22 : 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: horizontalSizeClass == .regular ? 196 : 130, height: horizontalSizeClass == .regular ? 196 : 130)
                        .background(Color.green)
                        .cornerRadius(horizontalSizeClass == .regular ? 30 : 20)
                        .shadow(color: Color.green.opacity(0.3), radius: horizontalSizeClass == .regular ? 15 : 8, x: 0, y: horizontalSizeClass == .regular ? 8 : 4)
                    }
                    
                    // 跳过按钮
                    Button(action: {
                        viewModel.skipWord()
                    }) {
                        VStack(spacing: horizontalSizeClass == .regular ? 16 : 12) {
                            Text("→")
                                .font(.system(size: horizontalSizeClass == .regular ? 70 : 45, weight: .bold))
                                .foregroundColor(.white)
                            Text(languageManager.localizedString("skip"))
                                .font(.system(size: horizontalSizeClass == .regular ? 22 : 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .frame(width: horizontalSizeClass == .regular ? 196 : 130, height: horizontalSizeClass == .regular ? 196 : 130)
                        .background(Color.orange)
                        .cornerRadius(horizontalSizeClass == .regular ? 30 : 20)
                        .shadow(color: Color.orange.opacity(0.3), radius: horizontalSizeClass == .regular ? 15 : 8, x: 0, y: horizontalSizeClass == .regular ? 8 : 4)
                    }
                }
                .padding(.bottom, horizontalSizeClass == .regular ? 60 : 80)
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
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
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
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                    .zIndex(999)
                }
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.isGameOver)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(category: .random, duration: 60)
    }
}
