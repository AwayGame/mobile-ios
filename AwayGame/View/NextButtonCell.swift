//
//  NextButtonCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

import UIKit

protocol NextDelegate: class {
    func didTapNext()
}

class NextButtonCell: UITableViewCell {
    
    static let identifier = "NextButtonCell"
    
    @IBOutlet weak var nextButton: UIButton!
    
    weak var delegate: NextDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        nextButton.layer.cornerRadius = 10.0
        nextButton.clipsToBounds = true
    }
    
    func configureCell() {
        styleButton()
    }
    
    // MARK: - Styling
    
    func styleButton() {
        nextButton.backgroundColor = Theme.Color.Green.primary
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(Theme.Color.black, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func nextTapped(_ sender: Any) {
        delegate?.didTapNext()
    }
}
