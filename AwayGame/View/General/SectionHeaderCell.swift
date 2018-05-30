//
//  SectionHeaderCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class SectionHeaderCell: UITableViewCell {
    
    static let identifier = "SectionHeaderCell"
    static let height: CGFloat = 100.0
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var underlineView: UIView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
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
