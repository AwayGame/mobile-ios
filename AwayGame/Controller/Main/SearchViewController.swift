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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var arriveButton: UIButton!
    @IBOutlet weak var arriveLabel: UILabel!
    @IBOutlet weak var arriveUnderlineView: UIView!
    @IBOutlet weak var departButton: UIButton!
    @IBOutlet weak var departUnderlineView: UIView!
    @IBOutlet weak var departLabel: UILabel!
    @IBOutlet weak var searchUnderlineView: UIView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var teamInstantSearchField: TextFieldWidget!
    @IBOutlet weak var teamSearchResults: HitsTableWidget!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    private var arriveString: String?
    private var departString: String?
    
    enum ButtonType {
        case arrive
        case depart
    }
    
    private var buttonType: ButtonType = .arrive
    
    fileprivate var gameData: [Event] = [] {
        didSet {
            print(gameData)
            if gameData.count > 0 {
                self.performSegue(withIdentifier: "NextButtonSegue", sender: self)
            }
        }
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        datePicker.minuteInterval = 15
        hitsTableView = teamSearchResults
        InstantSearch.shared.registerAllWidgets(in: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Search for a Game"
        doneButton.isHidden = true
        datePicker.isHidden = true
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }

    // MARK: - Styling

    func styleViews() {
        styleUnderlines()
        styleButtons()
        styleLabels()
        teamInstantSearchField.backgroundColor = Theme.Color.Background.primary
    }
    
    func styleUnderlines() {
        searchUnderlineView.backgroundColor = Theme.Color.Green.primary
        arriveUnderlineView.backgroundColor = Theme.Color.Green.primary
        departUnderlineView.backgroundColor = Theme.Color.Green.primary
    }
    
    func styleButtons() {
        arriveButton.setTitle("Set Date", for: .normal)
        arriveButton.setTitleColor(Theme.Color.darkText, for: .normal)
        departButton.setTitle("Set Date", for: .normal)
        departButton.setTitleColor(Theme.Color.darkText, for: .normal)
        doneButton.backgroundColor = Theme.Color.Background.primary
        doneButton.clipsToBounds = true
        doneButton.layer.cornerRadius = 10.0
        doneButton.setTitle("Done", for: .normal)
        nextButton.backgroundColor = Theme.Color.Background.primary
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10.0
        nextButton.setTitle("Next", for: .normal)
    }
    
    func styleLabels() {
        searchLabel.font = Theme.Font.h1
        searchLabel.textColor = Theme.Color.darkText
        searchLabel.text = "What team?"
        arriveLabel.font = Theme.Font.h1
        arriveLabel.textColor = Theme.Color.darkText
        arriveLabel.text = "When are you arriving?"
        departLabel.font = Theme.Font.h1
        departLabel.textColor = Theme.Color.darkText
        departLabel.text = "When are you leaving?"
        
    }
    
    // MARK: - HitsTableView data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, containing hit: [String : Any]) -> UITableViewCell {
        if let hitCell = tableView.dequeueReusableCell(withIdentifier: SearchHitCell.identifier, for: indexPath) as? SearchHitCell {
            hitCell.configureCell(with: hit["Display Name"] as? String)
            return hitCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, containing hit: [String : Any]) {
        teamSearchResults.isHidden = true
        teamInstantSearchField.text = hit["Display Name"] as? String
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchHitCell.height
    }
    
    // MARK: - API
    
    func findGames() {
        let team = teamInstantSearchField.text ?? ""
        let arrive = "\(arriveString ?? "")Z"
        let depart = "\(departString ?? "")Z"
        print(team, arrive, depart)
        AwayGameAPI.searchForGames(team: team, startDate:
            arrive, endDate: depart, completion: { events in
                self.gameData = events
        })
    }
    
    // MARK: - Actions
    
    @IBAction func arriveButtonTapped(_ sender: Any) {
        datePicker.isHidden = false
        doneButton.isHidden = false
        nextButton.isHidden = true
        buttonType = .arrive
        datePicker.isEnabled = true
        view.endEditing(true)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        let neatFormatter = DateFormatter()
        neatFormatter.dateFormat = "EEEE, MMM d HH:mm"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:00"
        if buttonType == .arrive {
            arriveString = dateFormatter.string(from: (datePicker?.date) ?? Date())
            arriveButton.setTitle(neatFormatter.string(from: (datePicker?.date) ?? Date()), for: .normal)
        } else {
            departString = dateFormatter.string(from: (datePicker?.date) ?? Date())
            departButton.setTitle(neatFormatter.string(from: (datePicker?.date) ?? Date()), for: .normal)
        }
        doneButton.isHidden = true
        nextButton.isHidden = false
        datePicker.isEnabled = false
    }
    
    @IBAction func departButtonTapped(_ sender: Any) {
        buttonType = .depart
        datePicker.isHidden = false
        doneButton.isHidden = false
        nextButton.isHidden = true
        datePicker.isEnabled = true
        view.endEditing(true)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        findGames()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Data transfer to next View Controlle
        if segue.identifier == "NextButtonSegue" {
            
            tripRequest.arrivalTime = arriveString
            tripRequest.departureTime = departString
            
            if let resultsVC = segue.destination as? ResultsTableViewController {
                print(gameData)
                resultsVC.tripRequest = self.tripRequest
                resultsVC.resultsData = self.gameData
            }
        }
    }
    
}
