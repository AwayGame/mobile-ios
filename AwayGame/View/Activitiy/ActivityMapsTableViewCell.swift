//
//  ActivityMapsTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Kingfisher
import UIKit

class ActivityMapsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    private var activity: Activity?
    static let identifier = "ActivityMapsCell"
    static let height: CGFloat = 210.0
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var mapsImageView: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        selectionStyle = .none
        background.backgroundColor = Theme.Color.Background.primary
        mapsImageView.layer.cornerRadius = 10.0
        mapsImageView.clipsToBounds = true
        mapsImageView.backgroundColor = Theme.Color.Background.primary
    }
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        if activity?.isGame ?? false{
            background.backgroundColor = Theme.Color.Green.selected
        }
        mapsImageView.setImage(withUrlString: activity?.mapsUrl)
    }
    
}
