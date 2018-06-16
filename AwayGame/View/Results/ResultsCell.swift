//
//  ResultsCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/11/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import Kingfisher

class ResultsCell: UITableViewCell {
    
    // MARK: - Initialization
    
    static let identifier = "ResultsCell"
    static let height: CGFloat = 140.0
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        gameImageView.backgroundColor = Theme.Color.Background.primary
        gameImageView.layer.cornerRadius = 10.0
        gameImageView.clipsToBounds = true
        gameLabel.textColor = Theme.Color.darkText
        gameLabel.font = Theme.Font.p1
        timeLabel.textColor = Theme.Color.darkText
        timeLabel.font = Theme.Font.p1
        self.selectionStyle = .none
    }
    
    func configureCell(event: Event?) {
        guard let event = event else { return }
        guard let images = event.images else { return }
        
        gameLabel.text = event.name ?? ""
        timeLabel.text = event.date?.localDate ?? ""
        
        if images.count > 1 {
            gameImageView.kf.setImage(with: URL(string: images[1].url ?? ""))
        } else if images.count > 0 {
            gameImageView.kf.setImage(with: URL(string: images[0].url ?? ""))
        }

    }
}
