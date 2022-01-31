//
//  ScrollingGameView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class ScrollingGameView: UIScrollView {
    typealias AdvanceLevel = () -> Void
    private let level: Game
    private let backgroundView: GameBackgroundView
    private var levelGenerator: GameLevelGenerator? = nil
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
    
    // Use this callback from outside to tell the game when to go to next level
    private(set) var advanceLevel: AdvanceLevel = { }
    var openLevel: ((LevelInfo) -> Void)? = nil
    
    private let mapWidth: CGFloat
    
    init(_ level: Game = .me) {
        self.level = level
        
        let geometry = GameGeometry(numberOfLevels: level.levels.count)
        
        self.backgroundView = GameBackgroundView(
            frame: .init(x: -100, y: 0, width: geometry.bounds.width + 100, height: geometry.bounds.height),
            waveCount: level.levels.count + 1
        )
        
        self.mapWidth = UIScreen.main.bounds.width
        
        super.init(frame: .zero)
        
        self.contentSize = geometry.bounds
        
        self.backgroundColor = .black
        
        self.levelGenerator = .init(config: .init(levels: level.levels,
                                                  bounds: geometry.bounds,
                                                  action: { [weak self] level in
            self?.openLevel?(level)
        }))
        
        self.advanceLevel = self.advanceNextLevel
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Lol no")
    }
    
    private func setup() {
        addSubview(backgroundView)
        
        self.gameViews = levelGenerator?.views() ?? []
        self.gameViews.forEach(addSubview(_:))
        self.gameViews.forEach { $0.animate() }
    }
    
    func addAndMovePlayer() {
        if !playerImageView.isDescendant(of: self) {
            self.addSubview(playerImageView)
        }
        
        playerImageView.clipsToBounds = true
        playerImageView.contentMode = .scaleAspectFit
        playerImageView.image = UIImage(named: "player")
        playerImageView.isHidden = isHidden
        playerImageView.layer.zPosition = 1
        animatePlayerMovement()
    }
    
    private func animatePlayerMovement() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.playerImageView.layer.removeAllAnimations()
            let playerMovement = CAKeyframeAnimation()
            playerMovement.setValue("AnimatePlayerMovement", forKeyPath: "id")
            playerMovement.keyPath = "position"
            playerMovement.duration = 3.0
            playerMovement.repeatCount = 1.0
            playerMovement.beginTime = CACurrentMediaTime()
            playerMovement.calculationMode = CAAnimationCalculationMode.paced
            self.playerImageView.transform = CGAffineTransform.init(rotationAngle: (CGFloat(Double.pi/180.0)))
            playerMovement.rotationMode = CAAnimationRotationMode.rotateAuto
            playerMovement.isRemovedOnCompletion = false
            playerMovement.delegate = self
            playerMovement.path = self.playerPathGenerator.safePath(to: self.currentLevel - 1)
            playerMovement.fillMode = .forwards
            self.playerImageView.layer.add(playerMovement, forKey: "AnimatePlayerMovement")
        }
    }
    
    private func scroll() {
        if gameViews.indices.contains(currentLevel) {
            let levelIndicatorFrame = gameViews[currentLevel].frame
            let scrollPosition = levelIndicatorFrame.maxX - mapWidth - 120
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn) {
                    self.contentOffset = CGPoint.init(x: scrollPosition, y: 0.0)
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn) {
                    self.contentOffset = CGPoint.init(x: self.contentSize.width, y: 0.0)
                }
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
        playerImageView.isUserInteractionEnabled = false
    
        self.playersPathLayer = playersPathLayer
        self.layer.addSublayer(playersPathLayer)
    }
    
    private func advanceNextLevel() {
        addAndMovePlayer()
        playerPathGenerator.safePath(to: currentLevel).map(markPlayersPath(_:))
        currentLevel += 1
    }
}

extension ScrollingGameView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let key = anim.value(forKey: "id") as! String
        
        if flag, key == "NewLevelAnimation" {
            self.animatePlayerMovement()
        }
        
        if key == "AnimatePlayerMovement" {
            scroll()
        }
    }
}
