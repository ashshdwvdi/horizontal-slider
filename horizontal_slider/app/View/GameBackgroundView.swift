//
//  GameBackgroundView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import Foundation
import UIKit

final class GameBackgroundView: UIView {
    private let count: Int
    
    init(frame: CGRect, waveCount: Int) {
        self.count = waveCount
        super.init(frame: frame)
        addBackgroundImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Lol no")
    }
    
    private func addBackgroundImage() {
        let backgroundImageView = UIImageView(frame: frame)
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
        addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        // Mask Image
        let maskImageView = UIImageView()
        maskImageView.image = UIImage(systemName: "cloud.fill")
        maskImageView.contentMode = .scaleAspectFill
        maskImageView.frame = backgroundImageView.bounds

        // Apply mask to profile iamge
        backgroundImageView.mask = maskImageView
    }
}
