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
        styleNormal()
        groupLabel.font = Theme.Font.p1
        groupLabel.textColor = Theme.Color.darkText
    }
    
    func styleSelected() {
        roundedView.backgroundColor = Theme.Color.Green.selected
        roundedView.layer.borderColor = Theme.Color.Green.border.cgColor
        roundedView.layer.borderWidth = 1.0
    }
    
    func styleHighlighted() {
        roundedView.backgroundColor = Theme.Color.Background.highlighted
        roundedView.layer.borderWidth = 0.0
    }
    
    func styleNormal() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.borderWidth = 0.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true {
            styleSelected()
        } else {
            styleNormal()
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            styleHighlighted()
        } else {
            styleNormal()
        }
    }
    
}
