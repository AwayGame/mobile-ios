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
    let leagueLabel = UILabel()
    
    func configureCell(team: String?, league: String?) {
        setup()
        teamLabel.text = team ?? ""
        teamLabel.sizeToFit()
        leagueLabel.text = league ?? ""
        leagueLabel.sizeToFit()
    }
    
    func setup() {
        addSubview(teamLabel)
        addSubview(leagueLabel)
        
        self.backgroundColor = Theme.Color.Background.primary
        teamLabel.textColor = Theme.Color.darkText
        teamLabel.font = Theme.Font.p1
        leagueLabel.textColor = Theme.Color.lightText
        leagueLabel.font = Theme.Font.p3
        leagueLabel.textAlignment = .right
        
        
        teamLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        teamLabel.minimumScaleFactor = 0.5
        teamLabel.adjustsFontSizeToFitWidth = true
        teamLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0).isActive = true
        teamLabel.trailingAnchor.constraint(equalTo: leagueLabel.leadingAnchor, constant: 8.0).isActive = true
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        leagueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leagueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
        leagueLabel.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        leagueLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
}

