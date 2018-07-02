//
//  ActivityImageTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import Kingfisher

// TODO: Make Base TableViewCell Class and extend it for different objects

class ActivityImageTableViewCell: UITableViewCell {

    private var activity: Activity?
    static let identifier = "ActivityImageCell"
    static let height: CGFloat = 240.0
    
    // MARK: - Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var activityImageView: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        selectionStyle = .none
        background.backgroundColor = Theme.Color.Background.primary
        activityImageView.layer.cornerRadius = 10.0
        activityImageView.clipsToBounds = true
        activityImageView.backgroundColor = Theme.Color.Background.highlighted
    }
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        guard let activity = activity else { return }
        if activity.isGame {
            background.backgroundColor = Theme.Color.Green.selected
        }
        activityImageView.setImage(withUrlString: activity.displayImage)
    }
    
    // MARK: - Styling
    
    
    func styleViews() {
        
    }
    

}
