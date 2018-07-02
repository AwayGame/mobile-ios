//
//  ActivityRatingTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Kingfisher
import UIKit

class ActivityRatingTableViewCell: UITableViewCell {

    private var activity: Activity?
    static let identifier = "ActivityRatingCell"
    static let height: CGFloat = 56.0
    
    // MARK: - Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        selectionStyle = .none
        background.backgroundColor = Theme.Color.Background.primary
    }
    
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        if activity?.isGame ?? false {
            background.backgroundColor = Theme.Color.Green.selected
        }
        ratingImageView.image = #imageLiteral(resourceName: "large_5")
    }
    
    // MARK: - Styling
    
    
    func styleViews() {
        
    }
}
