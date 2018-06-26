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
    func saveTapped()
}

class TripHeaderCell: UITableViewCell {
    
    // TODO: Change to Paging Cell to use for both itineraries and activities
    
    static let identifier = "TripHeaderCell"
    static let height: CGFloat = 120.0
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    weak var delegate: TripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        saveButton.layer.cornerRadius = 10.0
        saveButton.clipsToBounds = true
        saveButton.titleLabel?.font = Theme.Font.p1
        saveButton.setTitleColor(Theme.Color.darkText, for: .normal)
        saveButton.backgroundColor = Theme.Color.Background.primary
        underlineView.backgroundColor = Theme.Color.Green.primary
        dateLabel.font = Theme.Font.p1
        dateLabel.textColor = Theme.Color.darkText
        nextButton.titleLabel?.font = Theme.Font.p1
        nextButton.setTitleColor(Theme.Color.darkText, for: .normal)
        previousButton.titleLabel?.font = Theme.Font.p1
        previousButton.setTitleColor(Theme.Color.darkText, for: .normal)
        self.selectionStyle = .none
    }
    
    func configureCell(withTitle title: String?) {
        print("TripHeaderCell configured")
        dateLabel.text = title
    }
    
    @IBAction func previousDayButtonTapped(_ sender: Any) {
        delegate?.previousDayTapped()
    }
    
    @IBAction func nextDayButtonTapped(_ sender: Any) {
        delegate?.nextDayTapped()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        print("SAVE TAPPED")
        delegate?.saveTapped()
    }
    
}
