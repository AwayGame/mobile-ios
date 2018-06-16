//
//  ActivityDescriptionTableViewCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ActivityDescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private var activity: Activity?
    static let identifier = "ActivityDescriptionCell"
    static var height: CGFloat = 10.0
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        background.backgroundColor = Theme.Color.Background.primary
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: descriptionLabel.sizeThatFits(size).height + 28.0)
    }
    
    
    func configureCell(withActivity activity: Activity?) {
        self.activity = activity
        guard let activity = activity else { return }
        descriptionLabel.text = activity.description ?? ""
    }
    
    // MARK: - Styling
    
    func styleViews() {
        
    }

}
