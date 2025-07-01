//
//  MGSpriteViewContainer.swift
//  Mercur Gaming
//
//


import SwiftUI
import SpriteKit


struct MGSpriteViewContainer: UIViewRepresentable {
    @StateObject var user = MEGUser.shared
    var scene: MEGGameScene
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
