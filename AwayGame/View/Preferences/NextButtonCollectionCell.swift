//
//  NextButtonCollectionCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/29/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import UIKit

protocol NextDelegate: class {
    func didTapNext()
}

class NextButtonCollectionCell: UICollectionViewCell {
    
    static let identifier = "NextButtonCollectionCell"
    static let height: CGFloat = 100.0
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var roundedView: UIView!
    weak var delegate: NextDelegate?
    
    override var isHighlighted: Bool {
        didSet {
            print("HERE")
            if isHighlighted {
                roundedView.backgroundColor = Theme.Color.Background.highlighted
            } else {
                roundedView.backgroundColor = Theme.Color.Background.primary
            }
        }
    }
    
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        roundedView.clipsToBounds = true
        styleButton()
        styleView()
    }
    
    // MARK: - Styling
    
    func styleView() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.cornerRadius = 10.0
    }
    
    func styleButton() {
        nextButton.backgroundColor = .clear
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(Theme.Color.darkText, for: .normal)
        nextButton.titleLabel?.font = Theme.Font.p1
    }

    // MARK: - Actions
    
    @IBAction func nextTapped(_ sender: Any) {
        delegate?.didTapNext()
    }
}
