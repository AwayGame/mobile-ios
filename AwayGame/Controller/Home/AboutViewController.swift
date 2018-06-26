//
//  AboutViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/20/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: "About")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutLabel.text = Settings.About.text
        aboutLabel.textColor = Theme.Color.darkText
        aboutLabel.font = Theme.Font.p3
    }

}
