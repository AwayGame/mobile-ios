//
//  ResultsTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    public var arrivalTime: String?
    public var departureTime: String?
    
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
        
        AwayGameAPI.createTrip(event: event, arrival: arrivalTime ?? "", depart: departureTime ?? "", preferences: Preferences())
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
