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
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    weak var delegate: CreateTripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configureCell() {
        
        styleBackground()
        styleTripLabel()
        styleAddButton()
        
        createTripLabel.text = "Create a new trip"
        addButton.setTitle("+", for: .normal)

    }
    
    // MARK: - Styling
    
    func styleBackground() {
        background.clipsToBounds = true
        background.layer.cornerRadius = 10.0
        background.backgroundColor = Theme.Color.Background.primary
    }
    
    func styleTripLabel() {
        createTripLabel.font = Theme.Font.body
        createTripLabel.textColor = Theme.Color.black
    }
    
    func styleAddButton() {
        addButton.titleLabel?.font = Theme.Font.h1
        addButton.setTitleColor(Theme.Color.black, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func addTripTapped(_ sender: Any) {
        delegate?.didCreatNewTrip()
    }
}
