import Foundation
import Combine
import UIKit

class GameViewModel: ObservableObject {
    @Published var currentWord: String = ""
    @Published var countdown: Int
    @Published var score: Int = 0
    @Published var isGameOver: Bool = false
    @Published var progress: Double = 1.0
    
    private var wordList: [String]
    private var usedWords: Set<String> = []
    private var timer: Timer?
    private let totalDuration: Int
    let category: GameCategory
    
    init(category: GameCategory, duration: Int) {
        self.category = category
        self.totalDuration = duration
        self.countdown = duration
        self.wordList = category.localizedWords()
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
        // 添加成功震动反馈
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        score += 1
        getRandomWord()
    }
    
    func skipWord() {
        // 添加轻微震动反馈
        let generator = UIImpactFeedbackGenerator(style: .light)
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
    
    func resumeGame() {
        if countdown > 0 && !isGameOver {
            startGame()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
