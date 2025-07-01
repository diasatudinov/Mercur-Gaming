//
//  MGSpriteViewContainer.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 01.07.2025.
//


import SwiftUI
import SpriteKit


struct MGSpriteViewContainer: UIViewRepresentable {
    @StateObject var user = UserPS.shared
    var scene: GameScene
    var level: Int
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.backgroundColor = .clear
        scene.scaleMode = .resizeFill
        scene.level = level
       
        skView.presentScene(scene)
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.frame = UIScreen.main.bounds
    }
}
