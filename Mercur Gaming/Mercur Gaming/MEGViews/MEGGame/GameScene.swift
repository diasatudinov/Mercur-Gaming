import SpriteKit

class GameScene: SKScene {
    // MARK: — nodes & textures
    private var bear: SKSpriteNode!
    private var walkTextures: [SKTexture] = []
    private var standTexture: SKTexture!

    // MARK: — touch control
    private var isTouching = false
    private var touchPoint: CGPoint?

    // MARK: — setup
    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupGrid()
        setupBear()
    }

    private func setupGrid() {
        let cols = 8, rows = 8
        let tileSize = CGSize(width: size.width / CGFloat(cols),
                              height: size.height / CGFloat(rows))
        // можно использовать SKTileMapNode, но здесь — просто линии:
        for i in 0...cols {
            let x = CGFloat(i) * tileSize.width
            let line = SKShapeNode()
            let path = CGMutablePath()
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
            line.path = path
            line.strokeColor = .lightGray
            addChild(line)
        }
        for j in 0...rows {
            let y = CGFloat(j) * tileSize.height
            let line = SKShapeNode()
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
            line.path = path
            line.strokeColor = .lightGray
            addChild(line)
        }
    }

    private func setupBear() {
        // загрузка текстур
        standTexture = SKTexture(imageNamed: "bear_stand")
        walkTextures = ["bear_walk1","bear_walk2","bear_walk3"].map { SKTexture(imageNamed: $0) }

        bear = SKSpriteNode(texture: standTexture)
        bear.size = CGSize(width: standTexture.size().width * 0.5,
                           height: standTexture.size().height * 0.5)
        // старт в центре сцены
        bear.position = CGPoint(x: size.width/2, y: size.height/2)
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
        // если уже анимируется — не стартуем заново
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
        let dt: CGFloat = 1.0 / CGFloat(self.view?.preferredFramesPerSecond ?? 60)
        let direction = CGVector(dx: target.x - bear.position.x,
                                 dy: target.y - bear.position.y)
        let distance = sqrt(direction.dx*direction.dx + direction.dy*direction.dy)
        if distance > speed * dt {
            let v = CGVector(dx: direction.dx / distance * speed * dt,
                             dy: direction.dy / distance * speed * dt)
            bear.position = CGPoint(x: bear.position.x + v.dx,
                                    y: bear.position.y + v.dy)
        } else {
            bear.position = target
        }
    }
}