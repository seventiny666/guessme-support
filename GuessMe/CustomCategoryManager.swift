import Foundation

// 自定义分类数据模型
struct CustomCategory: Identifiable, Codable {
    let id: UUID
    var name: String
    var words: [String]
    var icon: String
    let createdAt: Date
    
    init(id: UUID = UUID(), name: String, words: [String], icon: String = "⭐️", createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.words = words
        self.icon = icon
        self.createdAt = createdAt
    }
}

// 自定义分类管理器
class CustomCategoryManager: ObservableObject {
    @Published var customCategories: [CustomCategory] = []
    
    private let userDefaultsKey = "customCategories"
    
    static let shared = CustomCategoryManager()
    
    private init() {
        // 同步加载，确保init完成时数据已准备好
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let categories = try? JSONDecoder().decode([CustomCategory].self, from: data) {
            self.customCategories = categories
            print("📂 同步加载了 \(categories.count) 个自定义分类")
            for category in categories {
                print("📂 - \(category.name): \(category.words.count) 个词汇")
            }
        } else {
            print("📂 没有找到已保存的分类")
        }
    }
    
    // 加载自定义分类
    func loadCategories() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let categories = try? JSONDecoder().decode([CustomCategory].self, from: data) {
            DispatchQueue.main.async {
                self.customCategories = categories
                print("📂 加载了 \(categories.count) 个自定义分类")
                for category in categories {
                    print("📂 - \(category.name): \(category.words.count) 个词汇")
                }
                // 强制触发UI更新
                self.objectWillChange.send()
            }
        } else {
            print("📂 没有找到已保存的分类")
        }
    }
    
    // 保存自定义分类
    func saveCategories() {
        if let data = try? JSONEncoder().encode(customCategories) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize() // 强制同步
            print("💾 已保存 \(customCategories.count) 个分类到UserDefaults")
        }
    }
    
    // 强制刷新UI
    func refreshUI() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    // 添加分类
    func addCategory(_ category: CustomCategory) {
        print("➕ 添加分类: \(category.name), 词汇数: \(category.words.count)")
        DispatchQueue.main.async {
            self.customCategories.append(category)
            self.saveCategories()
            self.refreshUI() // 强制刷新UI
            print("➕ 当前总分类数: \(self.customCategories.count)")
        }
    }
    
    // 删除分类
    func deleteCategory(_ category: CustomCategory) {
        DispatchQueue.main.async {
            self.customCategories.removeAll { $0.id == category.id }
            self.saveCategories()
        }
    }
    
    // 更新分类
    func updateCategory(_ category: CustomCategory) {
        DispatchQueue.main.async {
            if let index = self.customCategories.firstIndex(where: { $0.id == category.id }) {
                self.customCategories[index] = category
                self.saveCategories()
            }
        }
    }
    
    // 更新分类名称和词汇
    func updateCategory(_ category: CustomCategory, name: String, words: [String]) {
        DispatchQueue.main.async {
            if let index = self.customCategories.firstIndex(where: { $0.id == category.id }) {
                self.customCategories[index].name = name
                self.customCategories[index].words = words
                self.saveCategories()
            }
        }
    }
    
    // 更新分类名称、词汇和图标
    func updateCategory(_ category: CustomCategory, name: String, words: [String], icon: String) {
        DispatchQueue.main.async {
            if let index = self.customCategories.firstIndex(where: { $0.id == category.id }) {
                self.customCategories[index].name = name
                self.customCategories[index].words = words
                self.customCategories[index].icon = icon
                self.saveCategories()
            }
        }
    }
}
