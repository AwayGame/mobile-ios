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
        background.backgroundColor = Theme.Color.Background.primary
    }
    
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        dateLabel.text = activity?.date ?? ""
        timeLabel.text = activity?.startTime ?? ""
    }
    
    // MARK: - Styling
    
    
    func styleViews() {
        
    }

}
