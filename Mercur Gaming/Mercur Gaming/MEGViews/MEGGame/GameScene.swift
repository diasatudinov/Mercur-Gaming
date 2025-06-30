//
//  GameScene.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 30.06.2025.
//


import SpriteKit

class GameScene: SKScene {
    // MARK: — nodes & textures
    private var bear: SKSpriteNode!
    private var walkTextures: [SKTexture] = []
    private var standTexture: SKTexture!
    private var backgroundNode: SKSpriteNode!
    
    // MARK: — touch control
    private var isTouching = false
    private var touchPoint: CGPoint?
    
    // MARK: — constants
    private let gridSize: CGFloat = 402
    private let cols = 8
    private let rows = 8
    private var gridOrigin: CGPoint = .zero
    
    // MARK: — setup
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupBackground()
        setupGrid()
        setupBear()
    }
    
    private func setupBackground() {
        // Ensure you have an asset named "grid_background"
        backgroundNode = SKSpriteNode(imageNamed: "grid_background")
        backgroundNode.size = CGSize(width: gridSize, height: gridSize)
        gridOrigin = CGPoint(x: (size.width - gridSize) / 2,
                             y: (size.height - gridSize) / 2)
        backgroundNode.position = CGPoint(x: gridOrigin.x + gridSize/2,
                                          y: gridOrigin.y + gridSize/2)
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
    }
    
    private func setupGrid() {
        // Draw grid lines over the background
        let tileWidth = gridSize / CGFloat(cols)
        let tileHeight = gridSize / CGFloat(rows)
        
        for i in 0...cols {
            let x = gridOrigin.x + CGFloat(i) * tileWidth
            let path = CGMutablePath()
            path.move(to: CGPoint(x: x, y: gridOrigin.y))
            path.addLine(to: CGPoint(x: x, y: gridOrigin.y + gridSize))
            let line = SKShapeNode(path: path)
            line.strokeColor = .clear
            addChild(line)
        }
        for j in 0...rows {
            let y = gridOrigin.y + CGFloat(j) * tileHeight
            let path = CGMutablePath()
            path.move(to: CGPoint(x: gridOrigin.x, y: y))
            path.addLine(to: CGPoint(x: gridOrigin.x + gridSize, y: y))
            let line = SKShapeNode(path: path)
            line.strokeColor = .clear
            addChild(line)
        }
    }
    
    private func setupBear() {
        standTexture = SKTexture(imageNamed: "bear_stand")
        walkTextures = ["bear_walk1", "bear_walk2", "bear_walk3"].map { SKTexture(imageNamed: $0) }
        
        bear = SKSpriteNode(texture: standTexture)
        bear.size = CGSize(width: standTexture.size().width * 0.5,
                           height: standTexture.size().height * 0.5)
        // Place bear at center of grid
        bear.position = CGPoint(x: gridOrigin.x + gridSize/2,
                                y: gridOrigin.y + gridSize/2)
        addChild(bear)
    }
    
    // MARK: — touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        isTouching = true
        touchPoint = loc
        startWalking()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        touchPoint = loc
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopWalking()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        stopWalking()
    }
    
    private func startWalking() {
        if bear.action(forKey: "walkAnim") == nil {
            let anim = SKAction.animate(with: walkTextures,
                                        timePerFrame: 0.15,
                                        resize: false,
                                        restore: false)
            let repeatWalk = SKAction.repeatForever(anim)
            bear.run(repeatWalk, withKey: "walkAnim")
        }
    }
    
    private func stopWalking() {
        isTouching = false
        touchPoint = nil
        bear.removeAction(forKey: "walkAnim")
        bear.texture = standTexture
    }
    
    // MARK: — movement
    override func update(_ currentTime: TimeInterval) {
        guard isTouching, let target = touchPoint else { return }
        let speed: CGFloat = 150  // pts/sec
        let dt: CGFloat = 1.0 / CGFloat(view?.preferredFramesPerSecond ?? 60)
        let direction = CGVector(dx: target.x - bear.position.x,
                                 dy: target.y - bear.position.y)
        let distance = hypot(direction.dx, direction.dy)
        
        // Rotate bear to face movement direction
        let angle = atan2(direction.dy, direction.dx) + .pi/2
        bear.zRotation = angle
        
        // Calculate next position
        var newPosition: CGPoint = bear.position
        if distance > speed * dt {
            let v = CGVector(dx: direction.dx / distance * speed * dt,
                             dy: direction.dy / distance * speed * dt)
            newPosition = CGPoint(x: bear.position.x + v.dx,
                                  y: bear.position.y + v.dy)
        } else {
            newPosition = target
        }
        
        // Clamp within grid bounds (accounting for bear size)
        let halfW = bear.size.width / 2
        let halfH = bear.size.height / 2
        let minX = gridOrigin.x + halfW
        let maxX = gridOrigin.x + gridSize - halfW
        let minY = gridOrigin.y + halfH
        let maxY = gridOrigin.y + gridSize - halfH
        
        let clampedX = min(max(newPosition.x, minX), maxX)
        let clampedY = min(max(newPosition.y, minY), maxY)
        
        bear.position = CGPoint(x: clampedX, y: clampedY)
    }
}
