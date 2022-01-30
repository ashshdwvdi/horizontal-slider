//
//  ScrollingGameView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class ScrollingGameView: UIScrollView, UIScrollViewDelegate {
    private let level: GameLevel
    
    init(_ level: GameLevel = .myJourneyLevels) {
        self.level = level
        super.init(frame: .zero)
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterface() {
        self.delegate = self
        self.backgroundColor = .white
        self.contentSize = GameGeometry(numberOfLevels: level.levels.count).bounds
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
