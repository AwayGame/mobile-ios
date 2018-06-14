//
//  ActivityDetailsCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/13/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import UIKit

class ActivityDetailsCell: UITableViewCell {
    
    static let identifier = "ActivityDetailsCell"
    static let height: CGFloat = 674.0
    
    var activity: Activity?
    
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var activityDescription: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reviewStars: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var mapsImageView: UIImageView!
    
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        dateLabel.font = Theme.Font.p1
        dateLabel.textColor = Theme.Color.darkText
        
        activityDescription.font = Theme.Font.p1
        activityDescription.textColor = Theme.Color.darkText
        
        timeLabel.font = Theme.Font.p1
        timeLabel.textColor = Theme.Color.darkText
        
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        roundedView.backgroundColor = Theme.Color.Background.primary
    }
    
    func configureCell(with activity: Activity?) {
        self.activity = activity
        guard let activity = activity else { return }
        
        dateLabel.text = activity.timeframe
        timeLabel.text = activity.startTime
        print(activity.timeframe)
        print(activity.mapsUrl)
        mapsImageView.kf.setImage(with: URL(string: activity.mapsUrl ?? ""))
        reviewStars.image = #imageLiteral(resourceName: "large_3") //TODO: Create image helper function to return the image based on a float
        activityDescription.text = activity.address
        if !(activity.photos?.isEmpty ?? false) {
            activityImageView.kf.setImage(with: URL(string: activity.photos?[0] ?? ""))
        }
        
    }
    
}
