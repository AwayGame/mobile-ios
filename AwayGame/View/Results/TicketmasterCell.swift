//
//  TripmasterCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 7/1/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class TicketmasterCell: UITableViewCell {

    static let identifier = "TicketmasterCell"
    static let height: CGFloat = 60.0
    
    
    @IBOutlet weak var ticketmasterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ticketmasterImageView.image = #imageLiteral(resourceName: "ticketmaster-logo")
        selectionStyle = .none
    }
    
}
