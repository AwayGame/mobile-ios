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
    @IBOutlet weak var dateLabel: UILabel!
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
        dateLabel.textColor = Theme.Color.darkText
        dateLabel.font = Theme.Font.p1
        self.selectionStyle = .none
    }
    
    func configureCell(event: Event?) {
        guard let event = event else { return }
        guard let images = event.images else { return }
        
        gameLabel.text = event.name ?? ""
        timeLabel.text = event.time ?? ""
        dateLabel.text = event.date ?? ""
        
        
        print(event.name)
        print(event.date)
        print(event.time)
        print(event.ticketUrl)
        
        if images.count > 3 {
            gameImageView.setImage(withUrlString: images[2].url)
        } else if images.count > 0 {
            gameImageView.setImage(withUrlString: images[0].url)
        }

    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            roundedView.backgroundColor = Theme.Color.Background.highlighted
        } else {
            roundedView.backgroundColor = Theme.Color.Background.primary
        }
    }
}
