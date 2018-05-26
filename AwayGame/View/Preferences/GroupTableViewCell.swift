//
//  GroupTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/25/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    static let identifier = "GroupCell"
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
