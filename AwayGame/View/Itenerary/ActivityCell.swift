//
//  ActivityCell.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
// import Uber

protocol ActivityDelegate: class {
    func didTapUber()
}

class ActivityCell: UITableViewCell {

    static let identifier = "ActivityCell"
    
    var cellHeight: CGFloat = 220.0
    
    var activity: Activity? {
        didSet {
            updateConstraints()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    weak var delegate: ActivityDelegate?
    
    // Uber views
    
    @IBOutlet weak var uberBackgroundView: UIView!
    @IBOutlet weak var uberBackgroundHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var uberBackgroundBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        roundedView.layer.cornerRadius = 10.0
        roundedView.clipsToBounds = true
        timeLabel.font = Theme.Font.p1
        timeLabel.textColor = Theme.Color.darkText
        titleLabel.font = Theme.Font.p1
        titleLabel.textColor = Theme.Color.darkText
        activityImageView.layer.cornerRadius = 10.0
        activityImageView.clipsToBounds = true
        uberBackgroundView.layer.cornerRadius = 10.0
        uberBackgroundView.clipsToBounds = true
        selectionStyle = .none
    }
    
    func configureCell(with activity: Activity?) {
        print("ActivityCell configured")
        self.activity = activity
        guard let activity = activity else { return }
        titleLabel.text = activity.name ?? ""
        timeLabel.text = activity.startTime ?? ""
        activityImageView.kf.setImage(with: URL(string: activity.displayImage ?? ""))
    }
    
    override func updateConstraints() {
        print("updating constraints")
        super.updateConstraints()
        guard let activity = self.activity else { return }
        guard let _ = activity.needsUber else {
            uberBackgroundHeightConstraint.constant = 0.0
            uberBackgroundBottomConstraint.constant = 0.0
            cellHeight = 136.0
            return
        }
        print("This Cell Needs Uber \(activity.name ?? "")")
        cellHeight = 220.0
        uberBackgroundHeightConstraint.constant = 60.0
        uberBackgroundBottomConstraint.constant = 16.0
    }
    
    @IBAction func uberUbttonTapped(_ sender: Any) {
        print("Uber tapped")
        delegate?.didTapUber()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            roundedView.backgroundColor = Theme.Color.Background.highlighted
        } else {
            roundedView.backgroundColor = Theme.Color.Background.primary
        }
    }

}

