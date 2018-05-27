//
//  ResultsTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    public var itineraryRequest: ItineraryRequest?
    
    public var resultsData: [Event?] = [] {
        didSet {
            print(resultsData)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Tableview data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let resultsCell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell {
            resultsCell.configureCell(event: resultsData[indexPath.row])
            return resultsCell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let event = resultsData[indexPath.row] else {
            return
        }
        itineraryRequest?.lat = event.latitude ?? ""
        itineraryRequest?.long = event.longitude ?? ""
        itineraryRequest?.eventId = event.id ?? ""
        itineraryRequest?.eventName = event.name ?? ""
        
        performSegue(withIdentifier: "GroupSegue", sender: self)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupSegue" {
            if let groupVC = segue.destination as? GroupTableViewController {
                groupVC.itineraryRequest = self.itineraryRequest
            }
        }
    }

}
