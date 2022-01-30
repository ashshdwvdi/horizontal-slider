//
//  GameLevel.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation

struct GameLevel {
    let levels: [LevelInfo]
}

struct LevelInfo {
    let title: String
    let heading: String
    let contents: [String]
}


