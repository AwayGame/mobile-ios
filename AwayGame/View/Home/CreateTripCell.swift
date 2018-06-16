//
//  CreateTripCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

protocol CreateTripDelegate: class {
    func didCreatNewTrip()
}

class CreateTripCell: UITableViewCell {

    static let identifier = "CreateTripCell"
    static let height: CGFloat = 120.0
    
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var createTripLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    weak var delegate: CreateTripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {
        
        styleBackground()
        styleLabels()
        
        createTripLabel.text = "Create a new trip"
        addLabel.text = "┼"

    }
    
    // MARK: - Styling
    
    func styleBackground() {
        background.clipsToBounds = true
        background.layer.cornerRadius = 10.0
        background.backgroundColor = Theme.Color.Background.primary
    }
    
    func styleLabels() {
        createTripLabel.font = Theme.Font.p1
        createTripLabel.textColor = Theme.Color.darkText
        addLabel.font = Theme.Font.p1
        addLabel.textColor = Theme.Color.darkText
    }
    
    // MARK: - Actions
    
    @IBAction func createTripTapped(_ sender: Any) {
        delegate?.didCreatNewTrip()
    }
}
