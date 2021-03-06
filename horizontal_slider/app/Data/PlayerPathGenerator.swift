//
//  PlayerPathGenerator.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 31/01/22.
//

import Foundation
import UIKit

final class PlayerPathGenerator {
    private var playerPaths: [CGPath] = []
    
    init(views: [GameLevelView]) {
        self.generate(for: views)
    }
    
    private func generate(for gameViews: [GameLevelView]) {
        var locations: [CGPoint] = []
        let firstView = gameViews[0]
        let width = firstView.frame.width
        let height = firstView.frame.height
        
        
        gameViews.forEach { view in
            locations.append(.init(x: view.frame.midX, y: view.frame.midY))
        }
        
        // start position on screen
        let initialPath = self.path(start: .init(x: width, y: height),
                             end: .init(x: firstView.frame.origin.x, y: firstView.frame.origin.y),
                             width: width)
        playerPaths.append(initialPath)
        
        // levels
        for i in 0..<(locations.count - 1) {
            let path = self.path(start: locations[i], end: locations[i + 1], width: width)
            playerPaths.append(path)
        }
        
        // end position on screen
        let lastView = gameViews[gameViews.count - 1]
        let finalPath = self.path(start: .init(x: lastView.frame.midX, y: lastView.frame.midY),
                                  end: .init(x: lastView.frame.maxX, y: lastView.frame.maxY),
                                  width: width)
        playerPaths.append(finalPath)
    }
    
    private func path(start: CGPoint, end: CGPoint, width: CGFloat?) -> CGPath {
        var playerMovements: [CGPoint] = []
        playerMovements.append(CGPoint(x: start.x, y: start.y))
        playerMovements.append(CGPoint(x: end.x, y: end.y))
        
        var controlPoints : [CGPoint] = []
        let constant = 120
        
        for index in 0...1 {
            var xValue = 0
            var yValue = 0
            
            if index == 0 {
                yValue = Int(playerMovements[index].y) + constant
            } else {
                yValue = Int(playerMovements[index].y) - constant
            }
            
            if let levelIndicatorWidth = width {
                xValue = (Int(playerMovements[index].x) >= Int(start.x - levelIndicatorWidth)) ?
                    Int(playerMovements[index].x) - constant :
                    Int(playerMovements[index].x) + constant
            }
        
            controlPoints.append(CGPoint(x: xValue, y: yValue))
        }
        
        let travelledPath: UIBezierPath = UIBezierPath.init()
        travelledPath.move(to: CGPoint(x: start.x, y: start.y))
        travelledPath.addCurve(
            to: CGPoint(x: end.x, y: end.y),
            controlPoint1: controlPoints[0],
            controlPoint2: controlPoints[1])
        return travelledPath.cgPath
    }
    
    func safePath(to level: Int) -> CGPath? {
        guard playerPaths.indices.contains(level) else { return nil }
        return playerPaths[level]
    }
}
