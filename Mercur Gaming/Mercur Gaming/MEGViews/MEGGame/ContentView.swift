//
//  ContentView.swift
//  Mercur Gaming
//
//


import SwiftUI
import SpriteKit

struct MEGGameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var collectedStates: [Bool] = [false, false, false]
    @State var timeRemaining: Int
    @State var level: Int
    @State private var gameWon: Bool = false
    @State private var gameOver: Bool = false
    @ObservedObject var shopVM: MEGShopViewModel
    private let scene: MEGGameScene = {
        let scene = MEGGameScene(size: UIScreen.main.bounds.size)
        scene.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    // Timer publisher
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                // Win or Lose overlay
                if gameWon {
                    Image(.appBgMEG)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                        
                    VStack {
                        Spacer()
                        ZStack{
                            Image(.winBgMEG)
                                .resizable()
                                .scaledToFit()
                            
                            VStack {
                                Spacer()
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(.homeBtnMEG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 100:50)
                                        .padding(.bottom)
                                }
                            }
                        }.frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 400:250)
                        Spacer()
                    }
                } else if gameOver {
                    Image(.appBgMEG)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                        
                    VStack {
                        Spacer()
                        ZStack{
                            Image(.loseBgMEG)
                                .resizable()
                                .scaledToFit()
                            
                            VStack {
                                Spacer()
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(.homeBtnMEG)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 100:50)
                                        .padding(.bottom)
                                }
                            }
                        }.frame(height: MEGDeviceInfo.shared.deviceType == .pad ? 350:200)
                        Spacer()
                    }
                } else {
                    ZStack(alignment: .top) {
                        VStack {
                            HStack(alignment: .top) {
                                
                                Spacer()
                                
                            }
                            Spacer()
                        }.background(
                            ZStack {
                                if let item = shopVM.currentBgItem {
                                    Image(item.image)
                                        .resizable()
                                        .edgesIgnoringSafeArea(.all)
                                        .scaledToFill()
                                }
                            }
                        )
                        // SpriteKit scene
                        MGSpriteViewContainer(scene: scene, level: level)
                            .ignoresSafeArea()
                        
                        VStack {
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
                                
                            }.padding([.top, .horizontal])
                            Spacer()
                        }
                        
                        // Countdown timer
                        Text("Timer - \(timeRemaining)")
                            .font(.system(size: MEGDeviceInfo.shared.deviceType == .pad ? 35:25, weight: .bold))
                            .foregroundColor(.yellow)
                            .padding(8)
                            .textCase(.uppercase)
                            .padding(.top, 40)
                            
                        
                        // Collectibles status
                        HStack(spacing: 20) {
                            ForEach(0..<3, id: \.self) { idx in
                                HStack {
                                    
                                    Text(collectedStates[idx] ? "1/1" : "0/1")
                                        .font(.system(size: MEGDeviceInfo.shared.deviceType == .pad ? 25:14, weight: .bold))
                                        .foregroundColor(.yellow)
                                        .padding(4)

                                    Image("collectible\(idx+1)")
                                        .resizable()
                                        .frame(width: MEGDeviceInfo.shared.deviceType == .pad ? 60:40, height: MEGDeviceInfo.shared.deviceType == .pad ? 60:40)
                                }
                            }
                        }
                        .padding(.top, 90)
                    }
                }
            }
            .onReceive(timer) { _ in
                guard !gameWon && !gameOver else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                if timeRemaining == 0 {
                    gameOver = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .didCollectItem)) { notif in
                if let idx = notif.userInfo?["index"] as? Int,
                   idx >= 0 && idx < collectedStates.count {
                    collectedStates[idx] = true
                }
                // Check win condition
                if collectedStates.allSatisfy({ $0 }) {
                    gameWon = true
                }
            }
            
        }
    }
}

#Preview {
    MEGGameView(timeRemaining: 45, level: 3, shopVM: MEGShopViewModel())
}

