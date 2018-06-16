//
//  TripHeaderCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/12/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import UIKit

protocol TripDelegate: class {
    func previousDayTapped()
    func nextDayTapped()
}

class TripHeaderCell: UITableViewCell {
    
    // TODO: Change to Paging Cell to use for both itineraries and activities
    
    static let identifier = "TripHeaderCell"
    static let height: CGFloat = 120.0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var underlineView: UIView!
    
    weak var delegate: TripDelegate?
    
    // MARK: - Initialization
    
    func setup() {
        saveButton.layer.cornerRadius = 10.0
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.font = Theme.Font.p1
        saveButton.setTitleColor(Theme.Color.darkText, for: .normal)
        saveButton.backgroundColor = Theme.Color.Background.primary
        underlineView.backgroundColor = Theme.Color.Green.primary
        dateLabel.font = Theme.Font.p1
        dateLabel.textColor = Theme.Color.darkText
    }
    
    func configureCell(withTitle title: String?) {
        setup()
        print("TripHeaderCell configured")
        dateLabel.text = title
    }
    
    @IBAction func previousDayButtonTapped(_ sender: Any) {
        delegate?.previousDayTapped()
    }
    
    @IBAction func nextDayButtonTapped(_ sender: Any) {
        delegate?.nextDayTapped()
    }
    
}
