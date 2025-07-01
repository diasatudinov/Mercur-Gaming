//
//  GameScene.swift
//  Mercur Gaming
//
//  Created by Dias Atudinov on 30.06.2025.
//


import SpriteKit

class GameScene: SKScene {
    let shopVM = MGShopViewModel()
    var level: Int?
    // MARK: — nodes & textures
    private var bear: SKSpriteNode!
    private var walkTextures: [SKTexture] = []
    private var standTexture: SKTexture!
    private var backgroundNode: SKSpriteNode!
    
    // MARK: — item textures & nodes
    private var collectibleTextures: [SKTexture] = []
    private var collectibleNodes: [SKSpriteNode] = []
    private var obstacleATexture: SKTexture!
    private var obstacleBTexture: SKTexture!
    private var obstacleNodes: [SKSpriteNode] = []
    private var collectedCount = 0
    
    // MARK: — touch control
    private var isTouching = false
    private var touchPoint: CGPoint?
    
    // MARK: — grid constants
    private let gridSize: CGFloat = 402
    private let cols = 8
    private let rows = 8
    private var gridOrigin: CGPoint = .zero
    
    // MARK: — setup
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setupBackground()
        setupGrid()
        setupBear()
        setupItems()
    }
    
    private func setupBackground() {
        guard let level = level else { return }
        backgroundNode = SKSpriteNode(imageNamed: "grid_background\(level)")
        backgroundNode.size = CGSize(width: gridSize, height: gridSize)
        gridOrigin = CGPoint(x: (size.width - gridSize) / 2,
                             y: (size.height - gridSize) / 2)
        backgroundNode.position = CGPoint(x: gridOrigin.x + gridSize/2,
                                          y: gridOrigin.y + gridSize/2)
        backgroundNode.zPosition = -1
        addChild(backgroundNode)
    }
    
    private func setupGrid() {
        let tileW = gridSize / CGFloat(cols)
        let tileH = gridSize / CGFloat(rows)
        for i in 0...cols {
            let x = gridOrigin.x + CGFloat(i) * tileW
            let path = CGMutablePath()
            path.move(to: CGPoint(x: x, y: gridOrigin.y))
            path.addLine(to: CGPoint(x: x, y: gridOrigin.y + gridSize))
            let line = SKShapeNode(path: path)
            line.strokeColor = .clear
            addChild(line)
        }
        for j in 0...rows {
            let y = gridOrigin.y + CGFloat(j) * tileH
            let path = CGMutablePath()
            path.move(to: CGPoint(x: gridOrigin.x, y: y))
            path.addLine(to: CGPoint(x: gridOrigin.x + gridSize, y: y))
            let line = SKShapeNode(path: path)
            line.strokeColor = .clear
            addChild(line)
        }
    }
    
    private func setupBear() {
        guard let skin = shopVM.currentSkinItem else { return }
        standTexture = SKTexture(imageNamed: "bear_stand\(skin.image)")
        walkTextures = ["bear_walk1\(skin.image)", "bear_walk2\(skin.image)", "bear_walk3\(skin.image)"].map { SKTexture(imageNamed: $0) }
        bear = SKSpriteNode(texture: standTexture)
        bear.size = CGSize(width: standTexture.size().width * 0.5,
                           height: standTexture.size().height * 0.5)
        bear.position = CGPoint(x: gridOrigin.x + gridSize/2,
                                y: gridOrigin.y + gridSize/2)
        addChild(bear)
    }
    
    private func setupItems() {
        collectibleTextures = ["collectible1", "collectible2", "collectible3"].map { SKTexture(imageNamed: $0) }
        obstacleATexture = SKTexture(imageNamed: "obstacleA")
        obstacleBTexture = SKTexture(imageNamed: "obstacleB")
        
        let tileW = gridSize / CGFloat(cols)
        let tileH = gridSize / CGFloat(rows)
        var positions: [CGPoint] = []
        for i in 0..<cols {
            for j in 0..<rows {
                let x = gridOrigin.x + CGFloat(i) * tileW + tileW/2
                let y = gridOrigin.y + CGFloat(j) * tileH + tileH/2
                positions.append(CGPoint(x: x, y: y))
            }
        }
        positions.shuffle()
        
        // Place collectibles
        for idx in 0..<3 {
            let node = SKSpriteNode(texture: collectibleTextures[idx])
            node.size = CGSize(width: tileW * 0.8, height: tileH * 0.8)
            node.position = positions.removeFirst()
            node.name = "collectible_\(idx)"
            addChild(node)
            collectibleNodes.append(node)
        }
        // Place obstacles A
        let countA = Int.random(in: 9...12)
        for _ in 0..<countA {
            let node = SKSpriteNode(texture: obstacleATexture)
            node.size = CGSize(width: tileW * 0.8, height: tileH * 0.8)
            node.position = positions.removeFirst()
            node.name = "obstacle"
            addChild(node)
            obstacleNodes.append(node)
        }
        // Place obstacles B
        let countB = Int.random(in: 6...8)
        for _ in 0..<countB {
            let node = SKSpriteNode(texture: obstacleBTexture)
            node.size = CGSize(width: tileW * 0.8, height: tileH * 0.8)
            node.position = positions.removeFirst()
            node.name = "obstacle"
            addChild(node)
            obstacleNodes.append(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        isTouching = true; touchPoint = loc; startWalking()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoint = touches.first?.location(in: self)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { stopWalking() }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) { stopWalking() }
    
    private func startWalking() {
        guard bear.action(forKey: "walkAnim") == nil else { return }
        let anim = SKAction.animate(with: walkTextures, timePerFrame: 0.15)
        bear.run(SKAction.repeatForever(anim), withKey: "walkAnim")
    }
    
    private func stopWalking() {
        isTouching = false; touchPoint = nil
        bear.removeAction(forKey: "walkAnim"); bear.texture = standTexture
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isTouching, let target = touchPoint else { return }
        let speed: CGFloat = 150
        let dt: CGFloat = 1.0 / CGFloat(view?.preferredFramesPerSecond ?? 60)
        let dx = target.x - bear.position.x, dy = target.y - bear.position.y
        let dist = hypot(dx, dy)
        bear.zRotation = atan2(dy, dx) + .pi/2
        
        var nextPos = bear.position
        if dist > speed * dt {
            nextPos = CGPoint(x: bear.position.x + dx / dist * speed * dt,
                              y: bear.position.y + dy / dist * speed * dt)
        } else { nextPos = target }
        
        // Clamp within grid
        let halfW = bear.size.width/2, halfH = bear.size.height/2
        let minX = gridOrigin.x+halfW, maxX = gridOrigin.x+gridSize-halfW
        let minY = gridOrigin.y+halfH, maxY = gridOrigin.y+gridSize-halfH
        nextPos.x = min(max(nextPos.x, minX), maxX)
        nextPos.y = min(max(nextPos.y, minY), maxY)
        
        // Obstacle collision
        for obs in obstacleNodes where obs.frame.contains(nextPos) {
            return
        }
        bear.position = nextPos
        
        // Check collectibles
        collectibleNodes = collectibleNodes.filter { item in
            if bear.frame.intersects(item.frame) {
                // Post notification for UI update
                if let name = item.name, let idx = Int(name.split(separator: "_").last!) {
                    NotificationCenter.default.post(name: .didCollectItem, object: nil,
                                                    userInfo: ["index": idx])
                }
                item.removeFromParent(); collectedCount += 1; return false
            }
            return true
        }
        if collectedCount >= 3 {
            isTouching = false
        }
    }
}


extension Notification.Name {
    static let didCollectItem = Notification.Name("didCollectItem")
}

