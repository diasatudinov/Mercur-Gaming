//
//  MEGShopView.swift
//  Mercur Gaming
//
//


import SwiftUI

struct MEGShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = MEGUser.shared
    @ObservedObject var viewModel: MGShopViewModel
    
    @State private var currentIndex = 0
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
                    }.padding([.top])
                }
                
                Image(.shopTextMEG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 40:20)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.shopBgItems, id: \.self) { item in
                            ZStack {
                                Image(item.icon)
                                    .resizable()
                                    .scaledToFit()
                                
                                VStack {
                                    Spacer()
                                    Button {
                                        if item.isBg {
                                            if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                viewModel.currentBgItem = item
                                            } else {
                                                if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                    
                                                    if user.money >= item.price {
                                                        user.minusUserMoney(for: item.price)
                                                        viewModel.boughtItems.append(item)
                                                    }
                                                }
                                            }
                                        } else {
                                            if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                viewModel.currentSkinItem = item
                                            } else {
                                                if !viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                    
                                                    if user.money >= item.price {
                                                        user.minusUserMoney(for: item.price)
                                                        viewModel.boughtItems.append(item)
                                                    }
                                                }
                                            }
                                        }
                                    } label: {
                                        if !item.isBg {
                                            if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                
                                                
                                                if let currentItem = viewModel.currentSkinItem, currentItem.name == item.name {
                                                    
                                                    Image(.purchasedBtnMEG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                    
                                                } else {
                                                    Image(.takeBtnMEG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                }
                                                
                                                
                                            } else {
                                                Image(.hundredBtnMEG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 55)
                                                
                                                
                                            }
                                        } else {
                                            if viewModel.boughtItems.contains(where: { $0.name == item.name }) {
                                                
                                                
                                                if let currentItem = viewModel.currentBgItem, currentItem.name == item.name {
                                                    
                                                    Image(.purchasedBtnMEG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                    
                                                } else {
                                                    Image(.takeBtnMEG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                }
                                                
                                                
                                            } else {
                                                Image(.hundredBtnMEG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: 55)
                                                
                                                
                                            }
                                        }
                                        
                                        
                                    }
                                }.padding(.horizontal, 32).padding(.bottom, 8)
                            }.frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 280:150)
                            
                        }
                    }
                }
                
                Spacer()
                
            }.padding(.horizontal)
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
    MEGShopView(viewModel: MGShopViewModel())
}
