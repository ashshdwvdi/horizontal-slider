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
    private var advanceLevel: ScrollingGameView.AdvanceLevel?
    
    override func loadView() {
        self.view = scrollingGameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advanceLevel = scrollingGameView.advanceLevel
        scrollingGameView.openLevel = self.loadGame(_:)
        start()
    }
    
    private func start() {
        advanceLevel?()
    }
    
    private func loadGame(_ level: LevelInfo) {
        let controller = LevelDetailsViewController(level, completion: advanceLevel)
        let navigation = UINavigationController(rootViewController: controller)
        self.present(navigation, animated: true, completion: nil)
    }
}
