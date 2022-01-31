//
//  LevelDetailsViewController.swift
//  horizontal_slider
//
//  Created by Ashish Dwivedi on 31/01/22.
//

import Foundation
import UIKit

final class LevelDetailsViewController: UITableViewController {
    private let level: LevelInfo
    private let completion: ScrollingGameView.AdvanceLevel?
    private let cellIdentifier = "cell"
    
    init(_ level: LevelInfo, completion: ScrollingGameView.AdvanceLevel?) {
        self.level = level
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Lol no!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = level.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(completeLevel))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    @objc private func completeLevel() {
        dismiss(animated: true, completion: self.completion)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return level.contents.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configure(at: indexPath)
    }
    
    private func configure(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = indexPath.section == 0 ? level.heading : level.contents[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
