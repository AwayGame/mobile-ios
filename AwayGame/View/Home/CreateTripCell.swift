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
    
    @IBOutlet weak var createTripLabel: UILabel!
    
    weak var delegate: CreateTripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {
        createTripLabel.text = "Create a new trip"
        createTripLabel.font = Theme.Font.h1
        createTripLabel.textColor = Theme.Color.black
    }
    
    // MARK: - Actions
    
    @IBAction func addTripTapped(_ sender: Any) {
        delegate?.didCreatNewTrip()
    }
}
