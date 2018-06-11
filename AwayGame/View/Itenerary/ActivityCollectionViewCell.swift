//
//  ActivityCollectionViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/31/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import Kingfisher

class ActivityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ActivityCollectionCell"

    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        activityImageView.layer.cornerRadius = 5.0
        activityImageView.clipsToBounds = true
        timeLabel.font = Theme.Font.p1
        titleLabel.font = Theme.Font.p1
    }
    
    func configureCell(activity: Activity?) {
        print("\n\nsetting labels\n\n")
        print(activity?.name)
        print(activity?.startTime)
        print(activity?.photos)
        //titleLabel.text = activity?.name ?? ""
        //timeLabel.text = activity?.startTime ?? ""
        //activityImageView.kf.setImage(with: URL(string: activity.ph))
    }
    
    // MARK: - Styling
        
}
