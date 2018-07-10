//
//  ResultsTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    public var tripRequest: TripRequest?
    
    weak var delegate: UserDelegate?
    
    public var resultsData: [Event]? = [] {
        didSet {
            print(resultsData)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "New Trip")
    }

    // MARK: - Tableview data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return resultsData?.count ?? 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? SectionHeaderCell.height : (indexPath.section == 1 ? ResultsCell.height : TicketmasterCell.height)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: "Which game?")
                return sectionHeaderCell
            }
        } else if indexPath.section == 1 {
            if let resultsCell = tableView.dequeueReusableCell(withIdentifier: ResultsCell.identifier, for: indexPath) as? ResultsCell {
                resultsCell.configureCell(event: resultsData?[indexPath.row])
                return resultsCell
            }
        } else {
            if let ticketmasterCell = tableView.dequeueReusableCell(withIdentifier: TicketmasterCell.identifier, for: indexPath) as? TicketmasterCell {
                return ticketmasterCell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 1 {
            return
        }
        
        guard let event = resultsData?[indexPath.row] else {
            return
        }
        
        tripRequest?.eventId = event.id ?? ""
        tripRequest?.eventName = event.name ?? ""
        tripRequest?.imageUrl = event.images?[0].url ?? ""
        
        performSegue(withIdentifier: "GroupSegue", sender: self)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GroupSegue" {
            if let groupVC = segue.destination as? GroupTableViewController {
                groupVC.tripRequest = self.tripRequest
                groupVC.delegate = self
            }
        }
    }

}

extension ResultsTableViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip, tripRequest: TripRequest?) {
        print("popping RESULTS...")
        navigationController?.popViewController(animated: false)
        delegate?.user(user, didSaveTrip: trip, tripRequest: tripRequest)
    }
}
