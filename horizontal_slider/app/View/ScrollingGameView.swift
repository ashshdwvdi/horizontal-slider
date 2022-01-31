//
//  ScrollingGameView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class ScrollingGameView: UIScrollView {
    private let level: Game
    private let backgroundView: GameBackgroundView
    private let levelGenerator: GameLevelGenerator
    private var gameViews: [GameLevelView] = []
    private let playerImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        imageView.image = UIImage(named: "player")
        return imageView
    }()
    
    private var currentLevel: Int = 0
    private var playersPathLayer: CAShapeLayer? = nil
    private lazy var playerPathGenerator: PlayerPathGenerator = {
        return PlayerPathGenerator(views: self.gameViews)
    }()
    
    init(_ level: Game = .me) {
        self.level = level
        
        let geometry = GameGeometry(numberOfLevels: level.levels.count)
        
        self.backgroundView = GameBackgroundView(
            frame: .init(x: -50, y: 0, width: geometry.bounds.width + 100, height: geometry.bounds.height),
            waveCount: level.levels.count + 1
        )
        
        self.levelGenerator = .init(config: .init(levels: level.levels,
                                                  bounds: geometry.bounds,
                                                  action: { level in
            print("🎬 : \(level.title)")
        }))
        
        super.init(frame: .zero)
        
        self.contentSize = geometry.bounds
        
        self.backgroundColor = .black
        
        self.setupHierarchy()
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Lol no")
    }
    
    private func setupHierarchy() {
        addSubview(backgroundView)
        
        self.gameViews = levelGenerator.views()
        self.gameViews.forEach(addSubview(_:))
        self.gameViews.forEach { $0.animate() }
    }
    
    func addPlayer() {
        if !playerImageView.isDescendant(of: self) {
            playerImageView.clipsToBounds = true
            playerImageView.contentMode = .scaleAspectFit
            playerImageView.image = UIImage(named: "player")
            playerImageView.isHidden = isHidden
            playerImageView.layer.zPosition = 1
            animatePlayerMovement(for: currentLevel)
            self.addSubview(playerImageView)
        }
    }
    
    private func animatePlayerMovement(for level: Int) {
        DispatchQueue.main.async {
            self.playerImageView.layer.removeAllAnimations()
            let playerMovement = CAKeyframeAnimation()
            playerMovement.setValue("AnimatePlayerMovement", forKeyPath: "id")
            playerMovement.keyPath = "position"
            playerMovement.duration = 1.0
            playerMovement.repeatCount = 0.9
            playerMovement.beginTime = CACurrentMediaTime()
            playerMovement.calculationMode = CAAnimationCalculationMode.paced
            self.playerImageView.transform = CGAffineTransform.init(rotationAngle: (CGFloat(Double.pi/180.0)))
            playerMovement.rotationMode = CAAnimationRotationMode.rotateAuto
            playerMovement.isRemovedOnCompletion = false
            playerMovement.delegate = self
            playerMovement.path = self.playerPathGenerator.safePath(to: level)
            playerMovement.fillMode = .forwards
            self.playerImageView.layer.add(playerMovement, forKey: "AnimatePlayerMovement")
        }
    }
    
    private func scrollToYPosition(_ xPosition: CGFloat) {
        let scrollPosition = xPosition - UIScreen.main.bounds.width / CGFloat(level.levels.count)
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear) {
                self?.contentOffset = CGPoint.init(x: scrollPosition, y: 0)
            }
        }
    }
    
    private func markPlayersPath(_ path: CGPath) {
        self.playersPathLayer?.removeFromSuperlayer()
        self.playersPathLayer = nil
        
        let playersPathLayer = CAShapeLayer()
        playersPathLayer.fillColor = UIColor.clear.cgColor
        playersPathLayer.strokeColor = UIColor.white.cgColor
        playersPathLayer.lineWidth = 2
        playersPathLayer.lineJoin = CAShapeLayerLineJoin.miter
        playersPathLayer.lineDashPattern = [12]
        playersPathLayer.lineCap = CAShapeLayerLineCap.round
        playersPathLayer.path = path
    
        self.playersPathLayer = playersPathLayer
        self.layer.addSublayer(playersPathLayer)
    }
}

extension ScrollingGameView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        let key = anim.value(forKey: "id") as! String
        
        if key == "AnimatePlayerMovement" {
            playerImageView.isHidden = false
        }
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let key = anim.value(forKey: "id") as! String
        
        if flag, key == "NewLevelAnimation" {
            let view = gameViews[currentLevel]
            self.animatePlayerMovement(for: currentLevel)
            self.scrollToYPosition(view.frame.origin.x)
        }
    }
}
