import SwiftUI

struct MGShopView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var user = MGUser.shared
    @ObservedObject var viewModel: MGShopViewModel
    
    @State private var currentIndex = 0
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack(alignment: .top) {
                        VStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                                
                            } label: {
                                Image(.backIconMG)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:50)
                            }
                            
                            MGCoinBg().opacity(0)
                        }
                        Spacer()
                        Image(.shopTextMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 210:105)
                        Spacer()
                        MGCoinBg()
                    }.padding([.top])
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex - 1 + viewModel.shopBgItems.count) % viewModel.shopBgItems.count
                        }
                    }) {
                        Image(.arrowLeftMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:60)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { i in
                            let index = (currentIndex - 1 + i + viewModel.shopBgItems.count) % viewModel.shopBgItems.count
                            ZStack {
                                Image(viewModel.shopBgItems[index].icon)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(i == 1 ? 1.0 : 1)
                                    .scaleEffect(i == 1 ? 1.0 : 0.8)
                                    .animation(.easeInOut, value: currentIndex)
                                if i == 1 {
                                    VStack {
                                        Spacer()
                                        
                                        Button {
                                            if viewModel.boughtItems.contains(where: { $0.name == viewModel.shopBgItems[index].name }) {
                                                viewModel.currentBgItem = viewModel.shopBgItems[index]
                                            } else {
                                                if !viewModel.boughtItems.contains(where: { $0.name == viewModel.shopBgItems[index].name }) {
                                                    
                                                    if user.money >= viewModel.shopBgItems[index].price {
                                                        user.minusUserMoney(for: viewModel.shopBgItems[index].price)
                                                        viewModel.boughtItems.append(viewModel.shopBgItems[index])
                                                    }
                                                }
                                            }
                                        } label: {
                                            if viewModel.boughtItems.contains(where: { $0.name == viewModel.shopBgItems[index].name }) {
                                                
                                                
                                                if let currentItem = viewModel.currentBgItem, currentItem.name == viewModel.shopBgItems[index].name {
                                                    Image(.usedTextMG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                        
                                                } else {
                                                    Image(.useTextMG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 50)
                                                }
                                                
                                                
                                            } else {
                                                if user.money >= viewModel.shopBgItems[index].price {
                                                    Image(.priceHundredMG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 55)
                                                } else {
                                                    Image(.priceHundredOffMG)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: 55)
                                                }
                                                
                                                
                                                
                                            }
                                            
                                        }
                                    }
                                }
                            }.frame(width: i == 1 ? (MGDeviceManager.shared.deviceType == .pad ? 400:250) : (MGDeviceManager.shared.deviceType == .pad ? 300:150), height: i == 1 ? (MGDeviceManager.shared.deviceType == .pad ? 400:250) : (MGDeviceManager.shared.deviceType == .pad ? 300:150))
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % viewModel.shopBgItems.count
                        }
                    }) {
                        Image(.arrowLeftMG)
                            .resizable()
                            .scaledToFit()
                            .frame(height: MGDeviceManager.shared.deviceType == .pad ? 100:60)
                            .scaleEffect(x: -1, y: 1)
                    }
                }
                Spacer()
            }
        }.background(
            ZStack {
                Image(.appBgMG)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            }
        )

    }
}

#Preview {
    MGShopView(viewModel: MGShopViewModel())
}
