
//
//  HomeTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FBSDKLoginKit
import FirebaseAuth
import MessageUI
import UIKit

protocol HomeDelegate: class {
    func userDidLogout()
}

class HomeTableViewController: UITableViewController {

    private var ItineraryData: [[Itinerary]] = [[], []] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: HomeDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "AwayGame"
        setupNavigation(controller: self.navigationController, hidesBar: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = Theme.Color.white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Firebase
    
    func setupFirebase() {
        
        // TODO: - Setup firebase reference for data
        //         When data is set, it will populate tableview
        
    }
    
    // MARK: - Tableview data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let createTripCell = tableView.dequeueReusableCell(withIdentifier: CreateTripCell.identifier, for: indexPath) as? CreateTripCell {
                createTripCell.configureCell()
                createTripCell.delegate = self
                return createTripCell
            }
        } else if indexPath.section == 1 {
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: "Upcoming Trips")
                return sectionHeaderCell
            }
        } else if indexPath.section == 2 {
            
        } else if indexPath.section == 3 {
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: "Past Trips")
                return sectionHeaderCell
            }
        } else if indexPath.section == 4 {
            
        } else if indexPath.section == 5 {
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: "More")
                return sectionHeaderCell
            }
        } else if indexPath.section == 6 {
            if let moreCell = tableView.dequeueReusableCell(withIdentifier: MoreCell.identifier, for: indexPath) as? MoreCell {
                moreCell.configureCell()
                moreCell.delegate = self
                return moreCell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 2:
                return ItineraryData[0].count
            case 4:
                return ItineraryData[1].count
            default:
                return 1
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // TODO: - Update to true value later
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            print("delete tapped")
            // TODO: Remove from data source and make POST request to delete
        }
        
        delete.backgroundColor = .red
        
        return [delete]
    }
    
    // MARK: - Actions
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("Sign out Successful")
        } catch let error as Error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Email
    
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            
            mailVC.setToRecipients([Info.Support.email])
            mailVC.setSubject(Info.Support.subject)
            mailVC.setMessageBody(Info.Support.message, isHTML: true)
            
            present(mailVC, animated: true)
        } else {
            if let url = URL(string: "mailto:\(Info.Support.email)") {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "SettingsSegue" {
            if let settingsVC = segue.destination as? SettingsViewController {
                settingsVC.delegate = self
            }
        }
    }
        
}

// MARK: - CreateTripDelegate

extension HomeTableViewController: CreateTripDelegate {
    
    func didCreatNewTrip() {
        performSegue(withIdentifier: "CreateTripSegue", sender: self)
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate

extension HomeTableViewController: MFMailComposeViewControllerDelegate {
    
}

// MARK: - MoreCellDelegate

extension HomeTableViewController: MoreCellDelegate {
    func supportTapped() {
        let alertController = UIAlertController(title: "Contact Support", message: "Send an email to AwayGame support, we'll get back to you ASAP", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Send Email", style: .default, handler: { (alert) in
            self.sendEmail()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func settingsTapped() {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }

}

// MARK: - SettingsDelegate

extension HomeTableViewController: SettingsDelegate {
    
    func userDidLogout() {
        delegate?.userDidLogout()
        // Put this in FirebaseHelper
        do {
            try Auth.auth().signOut()
            FBSDKLoginManager.init().logOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        print("USER LOGGED OUT.")
    }
    
}
