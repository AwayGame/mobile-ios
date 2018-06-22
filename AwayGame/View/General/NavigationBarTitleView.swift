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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        titleLabel.frame = frame
        titleLabel.textColor = Theme.Color.white
        titleLabel.font = Theme.Font.p1
        titleLabel.textAlignment = .right
    }
    
    func setTitle(_ title: String?) {
        self.titleLabel.text = title ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
