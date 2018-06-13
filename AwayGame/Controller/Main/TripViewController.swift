//
//  TripViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/30/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

class TripViewController: UIViewController {

    // MARK: - Properties
    
    public var tripRequest: TripRequest?
    public var trip: Trip?
    
    @IBOutlet weak var tripContainerView: UIView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingScreen()
        AwayGameAPI.createTrip(request: tripRequest) { response in
            self.trip = response
            self.tearDownLoadingScreen()
            
            if let itineraryVC = self.childViewControllers[0] as? ItineraryTableViewController {
                itineraryVC.trip = self.trip
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigation(controller: self.navigationController, hidesBar: true)
    }

    func setupLoadingScreen() {
        loadingBackgroundView.alpha = 1.0
        tripContainerView.isHidden = true
        loadingBackgroundView.backgroundColor = Theme.Color.Green.primary
        loadingLabel.text = "Building your AwayGame..."
        loadingLabel.textColor = Theme.Color.white
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo")
        loadingIndicator.color = Theme.Color.white
        loadingIndicator.type = .ballSpinFadeLoader
        loadingIndicator.startAnimating()
    }

    func tearDownLoadingScreen() {
        UIView.animate(withDuration: 1.0) {
            self.loadingBackgroundView.alpha = 0.0
            self.tripContainerView.isHidden = false
            self.loadingIndicator.stopAnimating()
            setupNavigation(controller: self.navigationController, hidesBar: false)
        }
    }

}
