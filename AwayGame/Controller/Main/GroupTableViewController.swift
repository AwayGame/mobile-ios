//
//  GroupTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/25/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {

    public var itineraryRequest: ItineraryRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Preferences.Group.text.count
        } else {
            return 0 // 1 for next button
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let groupCell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier, for: indexPath) as? GroupTableViewCell {
            groupCell.configureCell(text: Preferences.Group.text[indexPath.row], image: Preferences.Group.images[indexPath.row])
            return groupCell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let groupCell = tableView.dequeueReusableCell(withIdentifier: GroupTableViewCell.identifier, for: indexPath) as? GroupTableViewCell {
            groupCell.setSelected(true, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}
