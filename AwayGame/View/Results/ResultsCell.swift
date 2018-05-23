//
//  ResultsCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/11/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    // MARK: - Initialization
    
    static let identifier = "ResultsCell"
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configureCell(event: Event?) {
        idLabel.text = event?.id ?? ""
        gameLabel.text = event?.name ?? ""
        
    }
}
