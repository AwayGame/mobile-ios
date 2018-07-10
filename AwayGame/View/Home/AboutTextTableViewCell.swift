//
//  AboutTextTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/28/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class AboutTextTableViewCell: UITableViewCell {
    
    static let identifier = "AboutTextCell"
    
    @IBOutlet weak var aboutTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aboutTextLabel.textColor = Theme.Color.darkText
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: aboutTextLabel.sizeThatFits(size).height + 20.0)
    }
    
    func configureCell(withText text: String?, font: UIFont?) {
        aboutTextLabel.text = text
        aboutTextLabel.font = font
    }

}
