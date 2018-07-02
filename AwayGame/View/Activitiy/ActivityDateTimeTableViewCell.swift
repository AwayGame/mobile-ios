//
//  ActivityDateTimeTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ActivityDateTimeTableViewCell: UITableViewCell {

    private var activity: Activity?
    static let identifier = "ActivityDateTimeCell"
    static var height: CGFloat = 68.0
    
    // MARK: - Properties
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        selectionStyle = .none
        background.backgroundColor = Theme.Color.Background.primary
        dateLabel.font = Theme.Font.p1
        timeLabel.font = Theme.Font.p1
        dateLabel.textColor = Theme.Color.darkText
        timeLabel.textColor = Theme.Color.darkText
    }
    
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        if activity?.isGame ?? false {
            background.backgroundColor = Theme.Color.Green.selected
        }
        print(activity?.date)
        dateLabel.text = activity?.date ?? ""
        timeLabel.text = activity?.startTime ?? ""
    }
    
    // MARK: - Styling
    
    
    func styleViews() {
        
    }

}
