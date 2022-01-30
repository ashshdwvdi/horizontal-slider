//
//  ScrollingGameView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class ScrollingGameView: UIScrollView, UIScrollViewDelegate {
    private let level: Game
    private let backgroundView: GameBackgroundView
    
    init(_ level: Game = .me) {
        self.level = level
        
        let geometry = GameGeometry(numberOfLevels: level.levels.count)
        
        self.backgroundView = GameBackgroundView(
            frame: .init(x: 0, y: 0, width: geometry.bounds.width, height: geometry.bounds.height),
            waveCount: level.levels.count
        )
        
        super.init(frame: .zero)
        
        self.contentSize = geometry.bounds
        
        self.delegate = self
        
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
