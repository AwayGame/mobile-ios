//
//  SettingsViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/26/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit

protocol SettingsDelegate: class {
    func userDidLogout()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    weak var delegate: SettingsDelegate?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func aboutTapped(_ sender: Any) {
        
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.delegate?.userDidLogout()
    }
}
