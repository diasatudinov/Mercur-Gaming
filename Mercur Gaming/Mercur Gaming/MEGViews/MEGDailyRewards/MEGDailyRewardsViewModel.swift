//
//  MEGDailyRewardsViewModel.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 30.06.2025.
//

import Foundation

class MEGDailyRewardsViewModel: ObservableObject {
    
    @Published var days: [DayMEG] = [
        DayMEG(id: 1, image: "day1"),
        DayMEG(id: 2, image: "day2"),
        DayMEG(id: 3, image: "day3"),
        DayMEG(id: 4, image: "day4"),
        DayMEG(id: 5, image: "day5"),
        DayMEG(id: 6, image: "day6"),
        DayMEG(id: 7, image: "day7"),
    ]
    
    @Published var currentDay: DayMEG = DayMEG(id: 1, image: "day1")
    {
        didSet {
            saveAchievementsItem()
        }
    }
    
    init() {
        loadAchievementsItem()
        
    }
    
    private let userDefaultsCurrentDayKey = "dailyRewards"

    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(currentDay) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsCurrentDayKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsCurrentDayKey),
           let loadedItem = try? JSONDecoder().decode(DayMEG.self, from: savedData) {
            currentDay = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
    func takeBtnPress() {
        UserPS.shared.updateUserMoney(for: 10)
        if let index = days.firstIndex(where: { $0.image == currentDay.image }) {
            switch index {
            case 0:
                currentDay = days[1]
            case 1:
                currentDay = days[2]
            case 2:
                currentDay = days[3]
            case 3:
                currentDay = days[4]
            case 4:
                currentDay = days[5]
            case 5:
                currentDay = days[6]
            case 6:
                currentDay = days[0]
            default:
                print("error")
            }
        }
    }
}

struct DayMEG: Codable, Hashable {
    var id: Int
    var image: String
}
