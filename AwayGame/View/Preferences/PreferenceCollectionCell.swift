//
//  PreferenceCollectionCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferenceCollectionCell: UICollectionViewCell {
    
    static let identifier = "PreferenceCell"
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var preferenceImageView: UIImageView!
    @IBOutlet weak var preferenceLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        preferenceImageView.layer.cornerRadius = 5.0
        preferenceImageView.clipsToBounds = true
        preferenceLabel.font = Theme.Font.p1
        styleNormal()
    }
    
    func configureCell(title: String?, image: UIImage?) {
        guard let title = title else { return }
        guard let image = image else { return }
        print(title)
        preferenceLabel.text = title
        preferenceImageView.image = image
    }
    
    // MARK: - Styling
    
    func styleSelected() {
        roundedView.backgroundColor = Theme.Color.Green.selected
        roundedView.layer.borderColor = Theme.Color.Green.border.cgColor
        roundedView.layer.borderWidth = 1.0
        preferenceImageView.layer.shadowRadius = 8.0
        preferenceImageView.layer.shadowColor = Theme.Color.black.cgColor
        preferenceImageView.layer.shadowOpacity = 1.0
    }
    
    func styleNormal() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.borderWidth = 0.0
    }
    
    func styleHighlighted() {
        roundedView.backgroundColor = Theme.Color.Background.highlighted
        roundedView.layer.borderWidth = 0.0
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                styleSelected()
            } else {
                styleNormal()
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                styleHighlighted()
            } else {
                styleNormal()
            }
        }
    }
    
}
