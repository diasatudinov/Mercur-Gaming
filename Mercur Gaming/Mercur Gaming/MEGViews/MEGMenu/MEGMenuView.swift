//
//  MEGMenuView.swift
//  Mercur Gaming
//
//

import SwiftUI

struct MEGMenuView: View {
    @State private var showGame = false
    @State private var showAchievement = false
    @State private var showShop = false
    @State private var showDailyTask = false
    @State private var showDailyReward = false
    
    @StateObject var dailyRewardVM = MEGDailyRewardsViewModel()
    @StateObject var dailyTasksVM = MEGDailyTaskViewModel()
    @StateObject var shopVM = MGShopViewModel()
        @StateObject var achievementVM = SRAchievementsViewModel()
    //    @StateObject var settingsVM = ITTPSettingsViewModel()
    //    @StateObject var gameVM = ITTPNewGameViewModel()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        showDailyReward = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.dailyRewardMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
                            
                        }
                    }
                    Spacer()
                    
                    Button {
                        showDailyTask = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.dailyTaskIconMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
                            
                        }
                    }
                    
                }
                
                VStack(spacing: 30) {
                    VStack {
                        Image(.welcomeTextMEG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 30:15)
                        
                        Image(.cozyBearTextMEG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 50:25)
                    }
                    VStack(spacing: 15) {
                        Image(.dailyTaskImageMEG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
                        Image(.dailyTaskTextMEG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 20:10)
                    }
                }.padding(.top, 30).padding(.bottom, 28)
                
                VStack(spacing: 20) {
                    Button {
                        showGame = true
                        
                    } label: {
                        
                        ZStack {
                            Image(.playIconMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 130:80)
                            
                        }
                    }
                    
                    Button {
                        showAchievement = true
                    } label: {
                        ZStack {
                            Image(.achievementsIconMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 130:80)
                            
                        }
                    }
                    
                    
                    
                    Button {
                        showShop = true
                    } label: {
                        Image(.shopIconMEG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 130:80)
                    }
                    
                }
                Spacer()
            }.padding(.horizontal)
            
            
        }.padding()
            .background(
                ZStack {
                    Image(.appBgMEG)
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .scaledToFill()
                }
            )
            .fullScreenCover(isPresented: $showGame) {
//                ITTPNewGameView(viewModel: gameVM)
            }
            .fullScreenCover(isPresented: $showAchievement) {
                SRAchivementsView(viewModel: achievementVM)
            }
            .fullScreenCover(isPresented: $showShop) {
                MGShopView(viewModel: shopVM)
            }
            .fullScreenCover(isPresented: $showDailyTask) {
                MEGDailyTaskView(viewModel: dailyTasksVM)
            }
            .fullScreenCover(isPresented: $showDailyReward) {
                MEGDailyRewardsView(viewModel: dailyRewardVM)
            }
    }
}


#Preview {
    MEGMenuView()
}
