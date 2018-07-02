//
//  AGButton.swift
//  AwayGame
//
//  Created by Blake Swaidner on 7/1/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class AGButton: UIButton {

    override func awakeFromNib() {
        backgroundColor = Theme.Color.Background.primary
        setTitleColor(Theme.Color.darkText, for: .normal)
        titleLabel?.font = Theme.Font.p1
        backgroundColor = Theme.Color.Background.primary
        layer.cornerRadius = 10.0
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Theme.Color.Background.highlighted : Theme.Color.Background.primary
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            titleLabel?.alpha = isEnabled ? 1.0 : 0.5
            self.alpha = isEnabled ? 1.0 : 0.7
        }
    }
    
}
