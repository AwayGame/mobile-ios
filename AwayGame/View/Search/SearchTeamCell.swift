//
//  SearchTeamCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import InstantSearch
import UIKit

class SearchTeamCell: UITableViewCell {
    
    static let identifier = "SearchTeamCell"
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var teamSearchBar: UISearchBar!
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {
        cellTitleLabel.text = "Team"
        teamSearchBar.barStyle = .default
        teamSearchBar.placeholder = "Team"
    }
    
    // MARK: - Actions
    
}

extension SearchTeamCell: UISearchBarDelegate {
    
}
