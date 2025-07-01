//
//  MEGLevelChoseView.swift
//  Mercur Gaming
//
//

import SwiftUI

struct MEGLevelChoseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var shopVM: MGShopViewModel

    @State var openGame1 = false
    @State var openGame2 = false
    @State var openGame3 = false
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
                        
                    }.padding([.top, .horizontal])
                }
                
                Image(.selectLevelTextMEG)
                    .resizable()
                    .scaledToFit()
                    .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 40:20)
                    .padding(.vertical, 20)
                
                    
                ScrollView {
                    VStack(spacing: 15) {
                        Button {
                            openGame1 = true
                            
                        } label: {
                            Image(.level1ImageMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 110:60)
                        }
                        
                        Button {
                            openGame2 = true
                        } label: {
                            Image(.level2ImageMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 110:60)
                        }
                        
                        Button {
                            openGame3 = true
                        } label: {
                            Image(.level3ImageMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 110:60)
                        }
                        
                        ForEach(Range(0...3)) { _ in
                            Image(.levelClosedImageMEG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 110:60)
                        }
                    }
                }
            }.fullScreenCover(isPresented: $openGame1) {
                MEGGameView(timeRemaining: 90, level: 1, shopVM: shopVM)
                
            }
            .fullScreenCover(isPresented: $openGame2) {
                MEGGameView(timeRemaining: 60, level: 2, shopVM: shopVM)
                
            }
            .fullScreenCover(isPresented: $openGame3) {
                MEGGameView(timeRemaining: 30, level: 3, shopVM: shopVM)
                
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
    MEGLevelChoseView(shopVM: MGShopViewModel())
}
