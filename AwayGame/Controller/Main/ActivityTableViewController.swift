//
//  ActivityTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController {

    public var activity: Activity? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let pageCell = tableView.dequeueReusableCell(withIdentifier: TripHeaderCell.identifier, for: indexPath) as? TripHeaderCell {
                return pageCell
            }
        } else {
            if let activityDetailsCell = tableView.dequeueReusableCell(withIdentifier: ActivityDetailsCell.identifier, for: indexPath) as? ActivityDetailsCell {
                activityDetailsCell.configureCell(with: activity)
                return activityDetailsCell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? TripHeaderCell.height : ActivityDetailsCell.height
    }

}
