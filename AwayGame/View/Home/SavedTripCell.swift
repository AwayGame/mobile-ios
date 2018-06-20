//
//  SavedTripCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import Kingfisher

protocol SavedTripDelegate: class {
    func didSelectTrip(withStub tripStub: TripStub?)
}

class SavedTripCell: UITableViewCell {

    static let identifier = "SavedTripCell"
    static let height: CGFloat = 120.0
    
    private var tripStub: TripStub?
    
    // MARK: - Initialization
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripTitleLabel: UILabel!
    
    weak var delegate: SavedTripDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        roundedView.backgroundColor = Theme.Color.Background.primary
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        
        tripTitleLabel.textColor = Theme.Color.darkText
        tripTitleLabel.font = Theme.Font.p1
        
        tripImageView.layer.cornerRadius = 5.0
        tripImageView.clipsToBounds = true
    }
    
    func configureCell(tripStub: TripStub?) {
        guard let stub = tripStub else { return }
        self.tripStub = stub
        tripTitleLabel.text = stub.title ?? ""
        tripImageView.kf.setImage(with: URL(string: stub.imageUrl ?? ""))
    }

    @IBAction func didTapCell(_ sender: Any) {
        delegate?.didSelectTrip(withStub: tripStub)
    }
    

}
