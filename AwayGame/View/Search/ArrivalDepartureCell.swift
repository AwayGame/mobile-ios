//
//  ArrivalDepartureCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ArrivalDepartureCell: UITableViewCell {
    
    static let identifier = "ArrivalDepartureCell"
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {
    }
    
    func getTimeData() -> [String] {
    
        // Use labels
        return ["11:00", "14:00"]
    
    }
}
