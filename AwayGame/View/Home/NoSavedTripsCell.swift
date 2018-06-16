//
//  NoSavedTripsCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class NoSavedTripsCell: UITableViewCell {
    
    static let identifier = "NoSavedTripsCell"
    static let height: CGFloat = 80.0
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        
        descriptionLabel.textColor = Theme.Color.darkText
        descriptionLabel.font = Theme.Font.p1
        
    }
    
    func configureCell(indexPath: IndexPath) {
        if indexPath.section == 2 {
            descriptionLabel.text = "No upcoming trips.\nCreate a new one now!"
        } else {
            descriptionLabel.text = "No past trips."
        }
    }
    
    
    
    
}
