//
//  GameGeometry.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import UIKit

struct GameGeometry {
    private let numberOfLevel: Int
    private let screenSize = UIScreen.main.bounds
    
    var bounds: CGSize {
        return .init(width: screenSize.width * CGFloat(numberOfLevel), height: screenSize.height)
    }
    
    init(numberOfLevels: Int) {
        self.numberOfLevel = numberOfLevels
    }
}
