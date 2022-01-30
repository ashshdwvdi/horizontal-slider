//
//  GameLevelView.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 30/01/22.
//

import UIKit

final class GameLevelView: UIView {
    typealias OpenLevel = (_ level: LevelInfo) -> Void
    typealias AnimateLevel = () -> Void
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let cloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let level: LevelInfo
    private let onTap: OpenLevel
    var animate: AnimateLevel = {}
    
    init(frame: CGRect, level: LevelInfo, onTap: @escaping OpenLevel) {
        self.level = level
        self.onTap = onTap
        super.init(frame: frame)
        
        addSubview(cloudImageView)
        cloudImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cloudImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cloudImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cloudImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        startButton.addTarget(self, action: #selector(startLevel(_:)), for: .touchUpInside)
        addSubview(startButton)
        startButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        startButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        startButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        animate = { [weak self] in
            DispatchQueue.main.async {
                self?.animateLevel()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let maskImageView = UIImageView()
        maskImageView.image = UIImage(systemName: "cloud.fill")
        maskImageView.contentMode = .scaleAspectFit
        maskImageView.frame = cloudImageView.bounds
        cloudImageView.mask = maskImageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("Lol no!")
    }
    
    @objc private func startLevel(_ sender: UIButton) {
        onTap(level)
    }
    
    private func animateLevel() {
        let oldPoint = self.frame.origin
        UIView.animate(withDuration: 1.0, delay: 0.6, options: .autoreverse) {
            self.frame = CGRect(x: self.frame.origin.x,
                                y: self.frame.origin.y - 10,
                                width: self.frame.size.width,
                                height: self.frame.size.height
            )
        } completion: { finished in
            if finished {
                self.frame.origin = oldPoint
                self.animateLevel()
            }
        }
    }
}
