//
//  MoreCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

protocol MoreCellDelegate: class {
    func supportTapped()
    func settingsTapped()
}

class MoreCell: UITableViewCell {
    
    static let identifier = "MoreCell"
    
    @IBOutlet weak var supportButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    weak var delegate: MoreCellDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        supportButton.clipsToBounds = true
        settingsButton.clipsToBounds = true
        self.selectionStyle = .none
    }
    
    func configureCell() {
        styleViews()
    }
    
    // MARK: - Styling
    
    func styleViews() {
        supportButton.setTitle("Support", for: .normal)
        supportButton.titleLabel?.font = Theme.Font.h1
        supportButton.layer.cornerRadius = 10.0
        
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = Theme.Font.h1
        settingsButton.layer.cornerRadius = 10.0
    }

    @IBAction func supportButtonTapped(_ sender: Any) {
        delegate?.supportTapped()
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        delegate?.settingsTapped()
    }
    
}
