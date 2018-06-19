//
//  PreferenceHeaderCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/18/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferenceHeaderCell: UICollectionViewCell {
    
    static let identifier = "PreferenceHeaderCell"
    static let height: CGFloat = 56.0
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(text: String?) {
        headerLabel.text = text
        styleViews()
    }
    
    // MARK: - Styling
    
    func styleViews() {
        headerLabel.font = Theme.Font.h1
        headerLabel.textColor = Theme.Color.darkText
        underlineView.backgroundColor = Theme.Color.Green.primary
    }
    
}
