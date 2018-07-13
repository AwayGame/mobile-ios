//
//  SearchViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import AlgoliaSearch
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
    @IBOutlet weak var teamSearchResults: HitsTableWidget!
    @IBOutlet weak var nextButton: AGButton!
    @IBOutlet weak var doneButton: AGButton!
    @IBOutlet weak var algoliaSearchWidget: SearchBarWidget!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var hitsTableViewHeightConstraint: NSLayoutConstraint!
    
    let maxTableViewHeight = 5 * SearchHitCell.height
    
    let friday5PM = Calendar.current.nextDate(after: Date(), matching: DateComponents(calendar: Calendar.current, day: 6, hour: 17), matchingPolicy: .nextTime)!
    let saturday11AM = Calendar.current.nextDate(after: Date(), matching: DateComponents(calendar: Calendar.current, day: 7, hour: 11), matchingPolicy: .nextTime)!
    
    private var arriveString: String?
    private var departString: String?
    
    weak var delegate: UserDelegate?
    
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
            } else {

                self.present(ErrorManager.noGamesAlert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:00"
        arriveString = dateFormatter.string(from: friday5PM)
        departString = dateFormatter.string(from: saturday11AM)
        searchBar.delegate = self
        styleViews()
        datePicker.minuteInterval = 15
        datePicker.minimumDate = Date() + 3600
        hitsTableView = teamSearchResults
        InstantSearch.shared.registerAllWidgets(in: self.view)
        hitsTableView.register(SearchHitCell.self, forCellReuseIdentifier: SearchHitCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "New Trip")
        doneButton.isHidden = true
        datePicker.isHidden = true
        hitsTableView.isHidden = true
    }

    // MARK: - Styling

    func styleViews() {
        styleUnderlines()
        styleButtons()
        styleLabels()
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = Theme.Color.darkText
        for subview in searchBar.subviews {
            for view in subview.subviews {
                if let textField = view as? UITextField {
                    textField.font = Theme.Font.p1
                    textField.textColor = Theme.Color.darkText
                }
            }

        }
    }
    
    func styleUnderlines() {
        searchUnderlineView.backgroundColor = Theme.Color.Green.primary
        arriveUnderlineView.backgroundColor = Theme.Color.Green.primary
        departUnderlineView.backgroundColor = Theme.Color.Green.primary
    }
    
    func styleButtons() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d h:mm a"
        arriveButton.setTitle(dateFormatter.string(from: friday5PM), for: .normal)
        arriveButton.setTitleColor(Theme.Color.darkText, for: .normal)
        departButton.setTitle(dateFormatter.string(from: saturday11AM), for: .normal)
        departButton.setTitleColor(Theme.Color.darkText, for: .normal)
        doneButton.setTitle("Done", for: .normal)
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
            hitCell.backgroundColor = indexPath.row % 2 == 0 ? Theme.Color.Background.primary : Theme.Color.Background.highlighted
            guard let team = hit["Display Name"] as? String else { return UITableViewCell() }
            guard let league = hit["League"] as? String else { return UITableViewCell() }
                
            hitCell.configureCell(team: team, league: league)
            return hitCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, containing hit: [String : Any]) {
        teamSearchResults.isHidden = true
        searchBar.text = hit["Display Name"] as? String
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchHitCell.height
    }
    
    // MARK: - API
    
    func findGames(withTeam team: String?) {
        let team = team ?? ""
        let arrive = "\(arriveString ?? "")Z"
        let depart = "\(departString ?? "")Z"
        print(team, arrive, depart)
        AwayGameAPI.searchForGames(team: team, startDate:
            arrive, endDate: depart, completion: { events in
                self.gameData = events
        })
    }
    
    // MARK: - Actions
    
    func setButtonText() {
        let dateFormatter = DateFormatter()
        let neatFormatter = DateFormatter()
        neatFormatter.dateFormat = "EEEE, MMMM d h:mm a"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:00"
        if buttonType == .arrive {
            AGAnalytics.logEvent(.arriveTimeSelected, parameters: nil)
            arriveString = dateFormatter.string(from: (datePicker?.date) ?? Date())
            arriveButton.setTitle(neatFormatter.string(from: (datePicker?.date) ?? Date()), for: .normal)
        } else {
            AGAnalytics.logEvent(.departTimeSelected, parameters: nil)
            departString = dateFormatter.string(from: (datePicker?.date) ?? Date())
            departButton.setTitle(neatFormatter.string(from: (datePicker?.date) ?? Date()), for: .normal)
        }
    }
    
    @IBAction func arriveButtonTapped(_ sender: Any) {
        setButtonText()
        buttonType = .arrive
        datePicker.isHidden = false
        doneButton.isHidden = false
        nextButton.isHidden = true
        datePicker.isEnabled = true
        view.endEditing(true)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        setButtonText()
        doneButton.isHidden = true
        nextButton.isHidden = false
        datePicker.isHidden = true
    }
    
    @IBAction func departButtonTapped(_ sender: Any) {
        setButtonText()
        buttonType = .depart
        datePicker.isHidden = false
        doneButton.isHidden = false
        nextButton.isHidden = true
        datePicker.isEnabled = true
        view.endEditing(true)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        findGames(withTeam: searchBar.text ?? "")
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
                resultsVC.delegate = self
            }
        }
    }
    
}

extension SearchViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip, tripRequest: TripRequest?) {
        print("popping SEARCH...")
        navigationController?.popViewController(animated: false)
        delegate?.user(user, didSaveTrip: trip, tripRequest: tripRequest)
    }
}



extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            hitsTableView.isHidden = true
            return
        }
        hitsTableView.isHidden = false
        print("Search Text: \(searchText)")
        algoliaSearchWidget.searchBar(algoliaSearchWidget, textDidChange: searchText)
        print("NUMBER OF ROWS\(tableView(hitsTableView, numberOfRowsInSection: 0))")
        
        let tableViewHeight = SearchHitCell.height * CGFloat(tableView(hitsTableView, numberOfRowsInSection: 0))
        hitsTableViewHeightConstraint.constant =  (tableViewHeight > maxTableViewHeight) ? maxTableViewHeight : tableViewHeight
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        algoliaSearchWidget.searchBarTextDidBeginEditing(algoliaSearchWidget)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        algoliaSearchWidget.onReset()
    }
    
}

