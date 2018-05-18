//
//  CalendarCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {
    
    static let identifier = "CalendarCell"
    

    
    weak var delegate: CreateTripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {

    }
    
}
