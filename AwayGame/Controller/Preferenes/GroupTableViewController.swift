//
//  GroupTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/25/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    public var tripRequest: TripRequest?
    
    weak var delegate: UserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: tripRequest?.eventName ?? "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return Preferences.Group.text.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: Preferences.Group.title)
                return sectionHeaderCell
            }
        } else if indexPath.section == 1 {
            if let groupCell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier, for: indexPath) as? GroupTableViewCell {
                groupCell.configureCell(text: Preferences.Group.text[indexPath.row], image: Preferences.Group.images[indexPath.row])
                return groupCell
            }
        }
    
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tripRequest?.preferences?.group = Preferences.Group.text[indexPath.row]
        performSegue(withIdentifier: "NextSegue", sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? SectionHeaderCell.height : GroupTableViewCell.height
    }    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Food.text, imageData: Preferences.Food.images)
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.preferenceType = .Food
                
            }
        }
    }
    
}

// MARK: - NextDelegate

extension GroupTableViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip) {
        print("popping Group...")
    navigationController?.popViewController(animated: false)
        delegate?.user(user, didSaveTrip: trip)
    }
}
