//
//  PreferenceCollectionCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class PreferenceCollectionCell: UICollectionViewCell {
    
    static let identifier = "PreferenceCell"
    
    @IBOutlet weak var preferenceImageView: UIImageView!
    @IBOutlet weak var preferenceLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = .red
        preferenceImageView.layer.cornerRadius = 5.0
        preferenceImageView.clipsToBounds = true
    }
    
    func configureCell(title: String?, image: UIImage?) {
        
        guard let title = title else { return }
        //guard let image = image else { //return }
        preferenceLabel.text = title
        //preferenceImageView.image = image
        
    }
    
}
