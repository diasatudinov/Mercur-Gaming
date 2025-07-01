//
//  MEGShopViewModel.swift
//  Mercur Gaming
//
//


import SwiftUI


class MEGShopViewModel: ObservableObject {
    @Published var shopBgItems: [MGItem] = [
        
        MGItem(isBg: false, name: "skin1", image: "gameRealSkin1MG", icon: "gameSkin1MG", price: 100),
        MGItem(isBg: false, name: "skin2", image: "gameRealSkin2MG", icon: "gameSkin2MG", price: 100),
        MGItem(isBg: false, name: "skin3", image: "gameRealSkin3MG", icon: "gameSkin3MG", price: 100),
        MGItem(isBg: true, name: "bg1", image: "gameRealBg1MEG", icon: "gameBg1MG", price: 100),
        MGItem(isBg: true, name: "bg2", image: "gameRealBg2MEG", icon: "gameBg2MG", price: 100),
        MGItem(isBg: true, name: "bg3", image: "gameRealBg3MEG", icon: "gameBg3MG", price: 100),
        
    ]
    
    @Published var boughtItems: [MGItem] = [
        MGItem(isBg: false, name: "skin1", image: "gameRealSkin1MG", icon: "gameSkin1MG", price: 100),
        MGItem(isBg: true, name: "bg1", image: "gameRealBg1MEG", icon: "gameBg1MG", price: 100),
    ] {
        didSet {
            saveBoughtItem()
        }
    }
    
    @Published var currentSkinItem: MGItem? {
        didSet {
            saveCurrentSkin()
        }
    }
    
    @Published var currentBgItem: MGItem? {
        didSet {
            saveCurrentBg()
        }
    }
    
    init() {
        loadCurrentBg()
        loadCurrentSkin()
        loadBoughtItem()
    }
    
    private let userDefaultsBgKey = "backgroundKeyMEG1"
    private let userDefaultsSkinKey = "skinKeyMEG"
    private let userDefaultsBoughtKey = "boughtShopItemsMEG"

    
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
            currentBgItem = shopBgItems[3]
            print("No saved data found")
        }
    }
    
    func saveCurrentSkin() {
        if let currentItem = currentSkinItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsSkinKey)
            }
        }
    }
    
    func loadCurrentSkin() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsSkinKey),
           let loadedItem = try? JSONDecoder().decode(MGItem.self, from: savedData) {
            currentSkinItem = loadedItem
        } else {
            currentSkinItem = shopBgItems[0]
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
    var isBg: Bool
    var name: String
    var image: String
    var icon: String
    var price: Int
}
