//
//  NavigationBarTitleView.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/21/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class NavigationBarTitleView: UIView {
    
    private var titleLabel = UILabel()
    
    init(withTitle title: String?) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 240.0, height: 36.0))
        self.addSubview(titleLabel)
        titleLabel.frame = frame
        titleLabel.textColor = Theme.Color.white
        titleLabel.font = Theme.Font.p1
        titleLabel.textAlignment = .right
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = title ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
