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
        roundedView.clipsToBounds = true
    }
    
    func configureCell(text: String?, image: UIImage?) {
        groupLabel.text = text ?? ""
        styleViews()
    }
    
    func styleViews() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.cornerRadius = 10.0
        groupLabel.font = Theme.Font.h1
        groupLabel.textColor = Theme.Color.darkText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        roundedView.backgroundColor = Theme.Color.Green.selected
        roundedView.layer.borderColor = Theme.Color.Green.border.cgColor
        roundedView.layer.borderWidth = 1.0
    }
    
}
