//
//  SettingsViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/26/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Firebase
import FirebaseAuth
import SafariServices
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
        setupViews()
        styleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "Settings")
    }
    
    func setupViews() {
        aboutButton.setTitle("About", for: .normal)
        websiteButton.setTitle("Website", for: .normal)
        logoutButton.setTitle("Logout ▶︎", for: .normal)
        copyrightLabel.text = Settings.copyrightText
    }
    
    func styleViews() {
        aboutButton.setTitleColor(Theme.Color.darkText, for: .normal)
        websiteButton.setTitleColor(Theme.Color.darkText, for: .normal)
        logoutButton.setTitleColor(Theme.Color.darkText, for: .normal)
        copyrightLabel.textColor = Theme.Color.darkText
        
        aboutButton.titleLabel?.font = Theme.Font.p2
        websiteButton.titleLabel?.font = Theme.Font.p2
        logoutButton.titleLabel?.font = Theme.Font.p2
        copyrightLabel.font = Theme.Font.p3
    }
    
    // MARK: - Actions
    
    @IBAction func aboutTapped(_ sender: Any) {
        performSegue(withIdentifier: "AboutSegue", sender: self)
    }
    
    @IBAction func websiteTapped(_ sender: Any) {
        let svc = SFSafariViewController(url: Settings.websiteUrl)
        svc.preferredBarTintColor = Theme.Color.white
        svc.preferredControlTintColor = Theme.Color.black
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.delegate?.userDidLogout()
    }
}
