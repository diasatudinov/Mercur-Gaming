//
//  MEGSplashScreen.swift
//  Mercur Gaming
//
//

import SwiftUI

struct MEGSplashScreen: View {
    @State private var scale: CGFloat = 1.0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Image(.appBgMEG)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Image(.loadingLogoMEG)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: scale
                    )
                    .onAppear {
                        scale = 0.8
                    }
                Spacer()
                
            }
            
            
        }
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
            }
        }
    }
}


#Preview {
    MEGSplashScreen()
}
