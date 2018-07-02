//
//  SearchHitCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class SearchHitCell: UITableViewCell {
    
    static let identifier = "SearchHitCell"
    static let height: CGFloat = 50.0
    
    let teamLabel = UILabel()
    
    func configureCell(with team: String?) {
        setup()
        teamLabel.text = team ?? ""
        teamLabel.sizeToFit()
    }
    
    func setup() {
        addSubview(teamLabel)
        self.backgroundColor = Theme.Color.Background.primary
        teamLabel.textColor = Theme.Color.darkText
        teamLabel.font = Theme.Font.p1
        teamLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

