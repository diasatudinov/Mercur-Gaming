//
//  ContentView.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 30.06.2025.
//


import SwiftUI
import SpriteKit

struct ContentView: View {
    // Инициализируем сцену один раз
    private let scene: GameScene = {
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        GeometryReader { proxy in
            SpriteView(scene: scene)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .ignoresSafeArea()
                .onAppear {
                    // Уточняем размер сцены по фактическому размеру контейнера
                    scene.size = proxy.size
                }
        }
    }
}

#Preview {
    ContentView()
}

