
//
//  HomeTableViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import MessageUI
import UIKit

class HomeTableViewController: UITableViewController {

    private var iteneraryData: [[Itenerary]] = [[], [], []] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "AwayGame"
        setupNavigation(controller: self.navigationController, hidesBar: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(supportTapped))
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
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return iteneraryData[0].count
            case 2:
                return iteneraryData[1].count
            case 3:
                return iteneraryData[2].count
            default:
                return 0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // TODO: - Update to true value later
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
    
    @objc func supportTapped() {
        let alertController = UIAlertController(title: "Contact Support", message: "Send an email to AwayGame support, we'll get back to you ASAP", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Send Email", style: .default, handler: { (alert) in
                self.sendEmail()
        }))
        present(alertController, animated: true, completion: nil)
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
       // Pass data if needed
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
