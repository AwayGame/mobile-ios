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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        } else if indexPath.section == 2 {
            if let nextCell = tableView.dequeueReusableCell(withIdentifier: NextButtonCell.identifier, for: indexPath) as? NextButtonCell {
                nextCell.configureCell()
                nextCell.delegate = self
                return nextCell
            }
        }
        
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return SectionHeaderCell.height
        } else if indexPath.section == 1 {
            return GroupTableViewCell.height
        } else {
            return NextButtonCell.height
        }
    }    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextSegue" {
            if let preferencesVC = segue.destination as? PreferencesCollectionViewController {
                
                if let index = tableView.indexPathForSelectedRow {
                    if let cell = tableView.cellForRow(at: index) as? GroupTableViewCell {
                        tripRequest?.preferences?.group = cell.groupLabel.text ?? ""
                        print("Group type: ", tripRequest?.preferences?.group ?? "error")
                    }
                }
                
                preferencesVC.setup(with: tripRequest?.eventName ?? "", textData: Preferences.Food.text, imageData: Preferences.Food.images)
                
                preferencesVC.tripRequest = self.tripRequest
                preferencesVC.type = .Food
                preferencesVC.delegate = self
                
            }
        }
    }
    
}

// MARK: - NextDelegate

extension GroupTableViewController: NextDelegate {
    
    func didTapNext() {
        if tableView.indexPathForSelectedRow != nil {
            performSegue(withIdentifier: "NextSegue", sender: self)
        } else {
            print ("Must select group type")
        }
    }
    
}

extension GroupTableViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip) {
        print("popping Group...")
    navigationController?.popViewController(animated: false)
        delegate?.user(user, didSaveTrip: trip)
    }
}
