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
    static let height: CGFloat = 136.0
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.clipsToBounds = true
        roundedView.layer.cornerRadius = 10.0
        self.selectionStyle = .none
    }
    
    func configureCell(text: String?, image: UIImage?) {
        groupLabel.text = text ?? ""
        groupImageView.image = image 
        styleViews()
    }
    
    // MARK: - Styling
    
    func styleViews() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        groupLabel.font = Theme.Font.p1
        groupLabel.textColor = Theme.Color.darkText
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            roundedView.backgroundColor = Theme.Color.Background.highlighted
        } else {
            roundedView.backgroundColor = Theme.Color.Background.primary
        }
    }
    
}
