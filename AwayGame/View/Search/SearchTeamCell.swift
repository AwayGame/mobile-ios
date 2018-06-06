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
    
    @IBOutlet weak var teamLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = Theme.Color.Background.primary
        teamLabel.textColor = Theme.Color.darkText
        teamLabel.font = Theme.Font.p1
    }
    
    func configureCell(with team: String?) {
        teamLabel.text = team ?? ""
    }
    
}

