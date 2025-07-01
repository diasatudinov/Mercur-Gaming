//
//  MEGAchivementsView.swift
//  Mercur Gaming
//
//


import SwiftUI

struct MEGAchivementsView: View {
    @StateObject var user = MEGUser.shared
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: MEGAchievementsViewModel
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(.backIconMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        Spacer()
                        
                        MEGCoinBg()
                    }.padding([.top, .horizontal])
                }
                Image(.achievementsTextMEG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 40:20)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.achievements, id: \.self) { achieve in
                            achievementItem(item: achieve)
                        }
                    }
                }
                
            }
        }.background(
            ZStack {
                Image(.appBgMEG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )
    }
    
    @ViewBuilder func achievementItem(item: MEGAchievement) -> some View {
        ZStack {
            VStack(spacing: 0) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
            
            }
            
            VStack {
                Spacer()
                Button {
                    if !item.isAchieved {
                        user.updateUserMoney(for: 100)
                    }
                    viewModel.achieveToggle(item)
                    
                } label: {
                    Image(item.isAchieved ? .takeYellowBtnMEG: .takeGrayBtnMEG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 100:50)
                }
            }.padding(.horizontal, 32).padding(.bottom, 8)
        }.frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 280:150)
    }
    
}

#Preview {
    MEGAchivementsView(viewModel: MEGAchievementsViewModel())
}
