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
}
