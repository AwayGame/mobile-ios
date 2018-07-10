//
//  ProfileImageView.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Kingfisher
import UIKit

class ProfileImageView: UIView {
    
    let profileImageView = UIImageView()
    
    private var imageUrl: String? {
        didSet {
            profileImageView.kf.setImage(with: URL(string: imageUrl ?? ""))
        }
    }
    
    init(frame: CGRect, imageUrl: String?) {
        super.init(frame: frame)
        profileImageView.frame = frame
        self.addSubview(profileImageView)
        profileImageView.backgroundColor = Theme.Color.darkText
        self.imageUrl = imageUrl
        self.backgroundColor = Theme.Color.Background.primary
        self.layer.cornerRadius = frame.width / 2
        self.layer.borderColor = Theme.Color.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
    
    func setImageUrl(_ imageUrl: String?) {
        self.imageUrl = imageUrl
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
