//
//  SearchViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import InstantSearch
import UIKit

class SearchViewController: HitsTableViewController {

    @IBOutlet weak var tableView: HitsTableWidget!
    
    fileprivate var gameData: [Game] = []
    private var cellHeights: [CGFloat] = [100.0, 400.0, 200.0, 50.0]
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InstantSearch.shared.registerAllWidgets(in: self.view)
        hitsTableView = tableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Search for a Game"
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }
    
    // MARK: - HitsTableViewController
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath)
        
        cell.textLabel?.text = hit["name"] as? String
        
        return cell
    }
    
    // MARK: - API
    
    func findGames() -> [Game] {
        // API Call goes here
        gameData = [Game(), Game(), Game()]
        
        return gameData
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Data transfer to next View Controller
        
        if segue.identifier == "NextButtonSegue" {
            // Send Game data to next view controller
            // Maybe send date/time info if needed
            
            if let resultsVC = segue.destination as? ResultsTableViewController {
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

