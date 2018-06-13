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
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
    private var currentItineraryIndex: Int = 0
    private var currentItinerary: Itinerary? {
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
        return currentItinerary?.activities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let headerCell = tableView.dequeueReusableCell(withIdentifier: TripHeaderCell.identifier, for: indexPath) as? TripHeaderCell {
                headerCell.delegate = self
                return headerCell
            }
        } else {
            if let activityCell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.identifier, for: indexPath) as? ActivityCell {
                activityCell.configureCell(with: currentItinerary?.activities?[indexPath.row])
                return activityCell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return TripHeaderCell.height
        } else {
            return ActivityCell.height
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ActivitySegue", sender: indexPath)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivitySegue" {
            if let activityVC = segue.destination as? ActivityTableViewController {
                guard let indexPath = sender as? IndexPath else { return }
                activityVC.activity = currentItinerary?.activities?[indexPath.row]
            }
        }
    }
    
}

// MARK: - TripDelegate

extension ItineraryTableViewController: TripDelegate {
    
    func previousDayTapped() {
        if currentItineraryIndex != 0 {
            currentItineraryIndex -= 1
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
    func nextDayTapped() {
        if currentItineraryIndex < trip?.itineraries?.count ?? 0 - 1 {
            currentItineraryIndex += 1
            currentItinerary = trip?.itineraries?[currentItineraryIndex]
        }
    }
    
}
