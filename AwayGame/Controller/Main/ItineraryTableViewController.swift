//
//  ItineraryTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ItineraryTableViewController: UITableViewController {

    public var trip: Trip? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.itineraries?[0].activities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let activityCell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.identifier, for: indexPath) as? ActivityCell {
            guard let trip = trip else { return UITableViewCell()}
            guard let itineraries = trip.itineraries else { return UITableViewCell()}
            activityCell.configureCell(with: itineraries[0].activities?[indexPath.row])
            print("here")
            return activityCell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
