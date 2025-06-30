//
//  SRAchievementsViewModel.swift
//  Mercur Gaming
//
//


import SwiftUI

class SRAchievementsViewModel: ObservableObject {
    
    @Published var achievements: [SRAchievement] = [
        SRAchievement(image: "achievement1MEG", isAchieved: false),
        SRAchievement(image: "achievement2MEG", isAchieved: false),
        SRAchievement(image: "achievement3MEG", isAchieved: false),
        SRAchievement(image: "achievement4MEG", isAchieved: false),

    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeyMEG"
    
    func achieveToggle(_ achive: SRAchievement) {
        guard let index = achievements.firstIndex(where: { $0.id == achive.id })
        else {
            return
        }
        achievements[index].isAchieved.toggle()
        
    }
    
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([SRAchievement].self, from: savedData) {
            achievements = loadedItem
        } else {
            print("No saved data found")
        }
    }
}

struct SRAchievement: Codable, Hashable, Identifiable {
    var id = UUID()
    var image: String
    var isAchieved: Bool
}
