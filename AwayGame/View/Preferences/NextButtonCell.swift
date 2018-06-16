//
//  NextButtonCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

protocol NextDelegate: class {
    func didTapNext()
}

class NextButtonCell: UITableViewCell {
    
    static let identifier = "NextButtonCell"
    static let height: CGFloat = 96.0
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var roundedView: UIView!
    weak var delegate: NextDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        roundedView.clipsToBounds = true
    }
    
    func configureCell() {
        styleButton()
        styleView()
    }
    
    // MARK: - Styling
    
    func styleView() {
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.cornerRadius = 10.0
    }
    
    func styleButton() {
        nextButton.backgroundColor = Theme.Color.Background.primary
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(Theme.Color.darkText, for: .normal)
        nextButton.titleLabel?.font = Theme.Font.p1
    }
    
    // MARK: - Actions
    
    @IBAction func nextTapped(_ sender: Any) {
        delegate?.didTapNext()
    }
}
