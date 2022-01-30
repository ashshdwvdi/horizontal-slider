//
//  GameMap.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class GameMapViewController: UIViewController {
    
    private let scrollingGameView: ScrollingGameView = ScrollingGameView()
    
    override func loadView() {
        self.view = scrollingGameView
    }
}
