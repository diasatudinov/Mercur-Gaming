//
//  MEGDailyTaskView.swift
//  Mercur Gaming
//
//

import SwiftUI

struct MEGDailyTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MEGDailyTaskViewModel
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
                
                Image(.dailyTaskTextMEG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 40:20)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.dailyTasks, id: \.self) { task in
                            ZStack {
                                Image(task)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack {
                                    Spacer()
                                    
                                    Button {
                                        UserPS.shared.updateUserMoney(for: 20)
                                    } label: {
                                        Image(.takeYellowBtnMEG)
                                            .resizable()
                                            .scaledToFit()
                                        
                                    }.padding()
                                }
                            }.frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 280:150)
                        }
                    }.padding(.horizontal)
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
}

#Preview {
    MEGDailyTaskView(viewModel: MEGDailyTaskViewModel())
}
