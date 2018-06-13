//
//  ActivityCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {

    static let identifier = "ActivityCell"
    static let height: CGFloat = 120.0
    
    var activity: Activity?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    // MARK: - Initialization
    
    func setup() {
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        timeLabel.font = Theme.Font.p1
        timeLabel.textColor = Theme.Color.darkText
        titleLabel.font = Theme.Font.p1
        titleLabel.textColor = Theme.Color.darkText
        
    }
    
    func configureCell(with activity: Activity?) {
        setup()
        print("ActivityCell configured")
        self.activity = activity
        guard let activity = activity else { return }
        titleLabel.text = activity.name ?? ""
        timeLabel.text = activity.startTime ?? ""
        if !(activity.photos?.isEmpty ?? true) {
            activityImageView.kf.setImage(with: URL(string: activity.photos?[0] ?? ""))
        }
    }

}

