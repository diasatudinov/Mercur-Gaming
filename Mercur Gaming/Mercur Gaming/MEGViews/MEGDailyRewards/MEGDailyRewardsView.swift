//
//  MEGDailyRewardsView.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 30.06.2025.
//

import SwiftUI

struct MEGDailyRewardsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MEGDailyRewardsViewModel
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
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        Spacer()
                       
                        CoinBgPS()
                        
                       
                        
                    }.padding([.horizontal, .top])
                }
                
                Image(.dailyRewardsTextMEG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 40:20)
                    .padding(.top, 60)
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.days, id: \.self) { day in
                        if viewModel.currentDay.image != day.image {
                            Image("\(day.image)BoxMEG")
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 40:76)
                        }
                    }
                }.padding(.top, 36)
                
                VStack {
                    Text("day \(viewModel.currentDay.id)")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.yellow)
                        .textCase(.uppercase)
                    
                    Image(.tenCoinsMEG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 150:100)
                }.padding(.top, 36)
                
                Button {
                    viewModel.takeBtnPress()
                    
                } label: {
                    Image(.takeBtnMEG)
                        .resizable()
                        .scaledToFit()
                        .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 130:70)
                }
                Spacer()
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
}

#Preview {
    MEGDailyRewardsView(viewModel: MEGDailyRewardsViewModel())
}
