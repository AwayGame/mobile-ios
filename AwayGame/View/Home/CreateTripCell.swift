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
    static let height: CGFloat = 100.0
        
    var createTripButton = UIButton()
    var addLabel = UILabel()
    var createTripLabel = UILabel()
    
    
    weak var delegate: CreateTripDelegate?
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func layoutConstraints() {
        
        createTripButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 4.0).isActive = true
        createTripButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -4.0).isActive = true
        createTripButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20.0).isActive = true
        createTripButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        createTripButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        createTripLabel.leadingAnchor.constraint(equalTo: createTripButton.leadingAnchor, constant: 20.0).isActive = true
        createTripLabel.topAnchor.constraint(equalTo: createTripButton.topAnchor).isActive = true
        createTripLabel.bottomAnchor.constraint(equalTo: createTripButton.bottomAnchor).isActive = true
        createTripLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        addLabel.trailingAnchor.constraint(equalTo: createTripButton.trailingAnchor, constant: -20.0).isActive = true
        addLabel.topAnchor.constraint(equalTo: createTripButton.topAnchor).isActive = true
        addLabel.bottomAnchor.constraint(equalTo: createTripButton.bottomAnchor).isActive = true
        addLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCell() {
        addViews()
        styleBackground()
        styleLabels()
        layoutConstraints()
        createTripLabel.text = "Create a new trip..."
        addLabel.text = "┼"
        createTripButton.addTarget(self, action: #selector(createTripTapped), for: .touchUpInside)

    }
    
    func addViews() {
        self.addSubview(createTripButton)
        self.addSubview(createTripLabel)
        self.addSubview(addLabel)
    }
    
    // MARK: - Styling
    
    func styleBackground() {
        createTripButton.clipsToBounds = true
        createTripButton.layer.cornerRadius = 10.0
        createTripButton.backgroundColor = Theme.Color.Background.primary
    }
    
    func styleLabels() {
        createTripLabel.font = Theme.Font.p1
        createTripLabel.textColor = Theme.Color.darkText
        addLabel.font = Theme.Font.p1
        addLabel.textColor = Theme.Color.darkText
    }
    
    // MARK: - Actions
    
    @objc func createTripTapped() {
        delegate?.didCreatNewTrip()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            createTripButton.backgroundColor = Theme.Color.Background.highlighted
        } else {
            createTripButton.backgroundColor = Theme.Color.Background.primary
        }
    }
}
