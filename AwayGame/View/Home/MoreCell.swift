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
    static let height: CGFloat = 90.0
    
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
        styleButton(btn: settingsButton, title: "Settings")
        styleButton(btn: supportButton, title: "Support")
    }
    
    func styleButton(btn: UIButton, title: String) {
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = Theme.Font.p1
        btn.backgroundColor = Theme.Color.Background.primary
        btn.setTitleColor(Theme.Color.darkText, for: .normal)
        btn.layer.cornerRadius = 10.0
    }
    
    // MARK: - Actions

    @IBAction func supportButtonTapped(_ sender: Any) {
        delegate?.supportTapped()
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        delegate?.settingsTapped()
    }
    
}
