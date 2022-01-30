//
//  GameLevelGenerator.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

struct GameLevelGenerator {
    struct LevelConfig {
        let levels: [LevelInfo]
        let bounds: CGSize
        let action: GameLevelView.OpenLevel
    }
    
    private let levels: [LevelInfo]
    private let width: CGFloat
    private let height: CGFloat
    private let onTap: GameLevelView.OpenLevel
    
    init(config: LevelConfig) {
        self.levels = config.levels
        self.width = config.bounds.width
        self.height = config.bounds.height
        self.onTap = config.action
    }
    
    func views() -> [GameLevelView] {
        let distance: CGFloat = (width / CGFloat(levels.count - 1)) / 2 + 50
        let yPosition: CGFloat = height / 2
        var xPosition: CGFloat = distance
        var generatedLevels: [GameLevelView] = []
        generatedLevels.reserveCapacity(levels.count)
        
        for (index, level) in levels.enumerated() {
            let yDelta: CGFloat = (index % 2 == 0) ? 100.0 : -200.0
            let frame = CGRect(x: xPosition, y: yPosition + yDelta, width: 200.0, height: 200.0)
            generatedLevels.append(GameLevelView(frame: frame, level: level, onTap: onTap))
            
            xPosition += CGFloat(distance)
        }
        
        return generatedLevels
    }
}
