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
    @ObservedObject var shopVM: MGShopViewModel
    private let scene: GameScene = {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    // Timer publisher
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { proxy in
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
                                .frame(height: ITTPDeviceInfo.shared.deviceType == .pad ? 100:50)
                        }
                        
                        Spacer()
                        
                    }.padding([.top, .horizontal])
                    Spacer()
                }
                
                // Countdown timer
                Text("Time: \(timeRemaining)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    .padding(.top, 10)
                
                // Collectibles status
                HStack(spacing: 20) {
                    ForEach(0..<3, id: \.self) { idx in
                        VStack {
                            Image("collectible\(idx+1)")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(collectedStates[idx] ? "1/1" : "0/1")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(4)
                        }
                    }
                }
                .padding(.top, 50)
               
                // Win or Lose overlay
                if gameWon {
                    Text("You Win!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                } else if gameOver {
                    Text("Time's Up! You Lose!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
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
    MEGGameView(timeRemaining: 45, level: 3, shopVM: MGShopViewModel())
}

