import SwiftUI


class MGShopViewModel: ObservableObject {
    @Published var shopBgItems: [MGItem] = [
        
        MGItem(name: "bg1", image: "gameRealBg1MG", icon: "gameBg1MG", price: 100),
        MGItem(name: "bg2", image: "gameRealBg2MG", icon: "gameBg2MG", price: 100),
        MGItem(name: "bg3", image: "gameRealBg3MG", icon: "gameBg3MG", price: 100),
        MGItem(name: "bg4", image: "gameRealBg4MG", icon: "gameBg4MG", price: 100),
        
    ]
    
    @Published var boughtItems: [MGItem] = [
        MGItem(name: "bg1", image: "gameRealBg1MG", icon: "gameBg1MG", price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentBgItem: MGItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    init() {
        loadCurrentBg()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "backgroundKeyMG"
    private let userDefaultsBoughtKey = "boughtShopItemsMG"

    
    func saveCurrentBg() {
        if let currentItem = currentBgItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsBgKey)
            }
        }
    }
    
    func loadCurrentBg() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBgKey),
           let loadedItem = try? JSONDecoder().decode(MGItem.self, from: savedData) {
            currentBgItem = loadedItem
        } else {
            currentBgItem = shopBgItems[0]
            print("No saved data found")
        }
    }
    
    func saveBoughtItem() {
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsBoughtKey)
        }
        
    }
    
    func loadBoughtItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsBoughtKey),
           let loadedItem = try? JSONDecoder().decode([MGItem].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct MGItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var image: String
    var icon: String
    var price: Int
}