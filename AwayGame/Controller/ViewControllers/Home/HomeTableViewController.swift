
//
//  HomeTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import CoreLocation
import FBSDKLoginKit
import FirebaseAuth
import MessageUI
import UIKit

protocol HomeDelegate: class {
    func userDidLogout()
}

class HomeTableViewController: UITableViewController {
    
    let profileImageView = ProfileImageView(frame: CGRect(origin: .zero, size: CGSize(width: 36.0, height: 36.0)), imageUrl: User.currentUser.photoUrl)
    
    private var user = User.currentUser {
        didSet {
            updateProfileImage()
        }
    }
    
    var tripStubData: [[TripStub]] = [[], []] {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: HomeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "AwayGame")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.hidesBarsOnTap = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        updateProfileImage()
    }
    
    func updateProfileImage() {
        profileImageView.setImageUrl(User.currentUser.photoUrl)
    }
    
    func setupTableView() {
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
        tableView.backgroundColor = Theme.Color.white
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    // MARK: - Firebase
    
    func setupFirebase() {
        initializeDatabaseSubscription()
    }
    
    func updateTripStubs(forUser user: User) {
        guard let stubs = user.tripStubs else { return }
        tripStubData = [[],[]]
        for stub in stubs {
            if let deleted = stub.isDeleted, !deleted {
                if let isCompleted = stub.isCompleted, isCompleted {
                    print("COMPLETED")
                    tripStubData[1].append(stub)
                } else {
                    print("NOT COMPLETED")
                    tripStubData[0].append(stub)
                }
            }
        }
    }
        
    // MARK: - Tableview data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let createTripCell = tableView.dequeueReusableCell(withIdentifier: CreateTripCell.identifier, for: indexPath) as? CreateTripCell {
                createTripCell.configureCell()
                createTripCell.delegate = self
                return createTripCell
            }
        } else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 {
            var title = ""
            if indexPath.section == 1 {
                title = "Upcoming Trips"
            } else if indexPath.section == 3 {
                 title = "Past Trips"
            } else {
                 title = "More"
            }
            
            if let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell {
                sectionHeaderCell.configureCell(text: title)
                return sectionHeaderCell
            }
        } else if indexPath.section == 2 || indexPath.section == 4 {
            
            let index = indexPath.section == 2 ? 0 : 1
            
            if tripStubData[index].isEmpty {
                if let noSavedTripsCell = tableView.dequeueReusableCell(withIdentifier: NoSavedTripsCell.identifier, for: indexPath) as? NoSavedTripsCell {
                    noSavedTripsCell.configureCell(indexPath: indexPath)
                    return noSavedTripsCell
                }
            } else {
                if let savedTripCell = tableView.dequeueReusableCell(withIdentifier: SavedTripCell.identifier, for: indexPath) as? SavedTripCell {
                    savedTripCell.delegate = self
                    savedTripCell.configureCell(tripStub: tripStubData[index][indexPath.row])
                    return savedTripCell
                }
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
                if tripStubData[0].isEmpty {
                    return 1
                    
                } else {
                    return tripStubData[0].count
                }
            case 4:
                if tripStubData[1].isEmpty {
                    return 1
                    
                } else {
                    return tripStubData[1].count
            }
            default:
                return 1
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return CreateTripCell.height
        case 1, 3, 5:
            return SectionHeaderCell.height
        case 2, 4:
            return SavedTripCell.height
        case 6:
            return MoreCell.height
        default:
            return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 2 || indexPath.section == 4 {
            return true
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        if tripStubData.isEmpty { return [] }
        
        let index = editActionsForRowAt.section == 2 ? 0 : 1
        if tripStubData[index].isEmpty { return [] }
        let stub = tripStubData[index][editActionsForRowAt.row]
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { action, index in
            if index.section == 0 {
                AGAnalytics.logEvent(.savedTripDeleted, parameters: nil)
            } else {
                AGAnalytics.logEvent(.pastTripDeleted, parameters: nil)
            }
            print("delete tapped")
            AwayGameAPI.deleteTrip(stub, user: User.currentUser, completion: {
                print("trip deleted")
            })
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
            
            mailVC.setToRecipients([Settings.Support.email])
            mailVC.setSubject(Settings.Support.subject)
            mailVC.setMessageBody(Settings.Support.message, isHTML: true)
            
            present(mailVC, animated: true)
        } else {
            if let url = URL(string: "mailto:\(Settings.Support.email)") {
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
        
        if segue.identifier == "CreateTripSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.delegate = self
            }
        }
        
        if segue.identifier == "TripSegue" {
            if let tripVC = segue.destination as? TripViewController {
                guard let tripStub = sender as? TripStub else { return }
                tripVC.isNewTrip = false
                tripVC.tripId = tripStub.id
                tripVC.tripTitle = tripStub.title
                tripVC.delegate = self
            }
        }
        
    }
}

// MARK: - CreateTripDelegate

extension HomeTableViewController: CreateTripDelegate {
    
    func didCreatNewTrip() {
        AGAnalytics.logEvent(.createTripTapped, parameters: nil)
        performSegue(withIdentifier: "CreateTripSegue", sender: self)
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate

extension HomeTableViewController: MFMailComposeViewControllerDelegate {
    
}

// MARK: - MoreCellDelegate

extension HomeTableViewController: MoreCellDelegate {
    func supportTapped() {
        AGAnalytics.logEvent(.supportTapped, parameters: nil)
        let alertController = UIAlertController(title: "Contact Support", message: "Send an email to AwayGame support, we'll get back to you ASAP", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Send Email", style: .default, handler: { (alert) in
            self.sendEmail()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func settingsTapped() {
        AGAnalytics.logEvent(.settingsTapped, parameters: nil)
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

// MARK: - UserDelegate

extension HomeTableViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip, tripRequest: TripRequest?) {
        navigationController?.popViewController(animated: false)
        print("Saving trip...")
        AGAnalytics.logEvent(.tripSaved, parameters: nil)
        AwayGameAPI.saveTrip(trip, tripRequest: tripRequest, user: user, completion: {
            print("TRIP SAVED")
        })
    }
}

// MARK: - SavedTripDelegate

extension HomeTableViewController: SavedTripDelegate {
    func didSelectTrip(withStub tripStub: TripStub?) {
        AGAnalytics.logEvent(.savedTripTapped, parameters: nil)
        guard let stub = tripStub else { return }
        performSegue(withIdentifier: "TripSegue", sender: stub)
    }
}


