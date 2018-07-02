//
//  AboutButtonTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/28/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

protocol AboutButtonDelegate: class {
    func didTapButton(_ button: UIButton?, withLink link: URL?)
}

class AboutButtonTableViewCell: UITableViewCell {
    
    static let identifier = "AboutButtonCell"
    static let height: CGFloat = 64.0
    
    @IBOutlet weak var aboutButton: UIButton!
    
    private var link: URL?
    weak var delegate: AboutButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aboutButton.setTitleColor(Theme.Color.darkText, for: .normal)
            aboutButton.layer.cornerRadius = 10.0
        aboutButton.clipsToBounds = true
    }
    
    func configureCell(withText text: String?, link: URL?) {
        aboutButton.setTitle(text ?? "", for: .normal)
        self.link = link
    }

    @IBAction func aboutButtonTapped(_ sender: Any) {
        delegate?.didTapButton(aboutButton, withLink: link)
    }
    
}
