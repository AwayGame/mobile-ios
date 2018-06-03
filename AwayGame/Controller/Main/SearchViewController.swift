//
//  SearchViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import InstantSearch
import InstantSearchCore

class SearchViewController: HitsTableViewController {
    
    public var tripRequest = TripRequest()
    
    // MARK: Properties
    @IBOutlet weak var teamInstantSearchField: TextFieldWidget!
    @IBOutlet weak var teamSearchResults: HitsTableWidget!
    
    fileprivate var gameData: [Event] = [] {
        didSet {
            print(gameData)
            if gameData.count > 0 {
                self.performSegue(withIdentifier: "NextButtonSegue", sender: self)
            }
        }
    }
    
    @IBOutlet weak var teamNameTextField: InstantSearch!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        hitsTableView = teamSearchResults
        InstantSearch.shared.registerAllWidgets(in: self.view)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath)
        
        cell.textLabel?.text = hit["name"] as? String
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Search for a Game"
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        tripRequest.arrivalTime = startTimeTextField.text ?? ""
        tripRequest.departureTime = endTimeTextField.text ?? ""
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Data transfer to next View Controller
        
        if segue.identifier == "NextButtonSegue" {
            // Send Game data to next view controller
            // Maybe send date/time info if needed
            
            if let resultsVC = segue.destination as? ResultsTableViewController {
                print(gameData)
                
                resultsVC.tripRequest = self.tripRequest
                resultsVC.resultsData = self.gameData
                
            }
            
        }
        
    }

}


//// MARK: - UITableViewDataSource
//
//extension SearchViewController: UITableViewDataSource {
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.row == 0 {
//            if let searchTeamCell = tableView.dequeueReusableCell(withIdentifier: SearchTeamCell.identifier, for: indexPath) as? SearchTeamCell {
//                searchTeamCell.configureCell()
//                return searchTeamCell
//            }
//
//        } else if indexPath.row == 1 {
//            if let calendarCell = tableView.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell {
//                calendarCell.configureCell()
//                return calendarCell
//            }
//
//        } else if indexPath.row == 2 {
//            if let ariveDepartCell = tableView.dequeueReusableCell(withIdentifier: ArrivalDepartureCell.identifier, for: indexPath) as? ArrivalDepartureCell {
//                ariveDepartCell.configureCell()
//                return ariveDepartCell
//            }
//
//        } else if indexPath.row == 3 {
//            if let nextCell = tableView.dequeueReusableCell(withIdentifier: NextButtonCell.identifier, for: indexPath) as? NextButtonCell {
//                nextCell.delegate = self
//                nextCell.configureCell()
//                return nextCell
//            }
//        }
//
//        return UITableViewCell()
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return cellHeights[indexPath.row]
//    }
//
//}
//
//// MARK: - UITableViewDelegate
//
//extension SearchViewController: UITableViewDelegate {
//
//}
//
//// MARK: - NextDelegate
//
//extension SearchViewController: NextDelegate {
//
//    func didTapNext() {
//        if findGames().isEmpty {
//            performSegue(withIdentifier: "NoGamesSegue", sender: self)
//        } else {
//            performSegue(withIdentifier: "NextButtonSegue", sender: self)
//        }
//    }
//
//}

