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
    
    public var tripRequest: TripRequest?  {
        didSet {
            tripTitle = tripRequest?.eventName
        }
    }
    
    var tripTitle: String?
    
    public var trip: Trip? {
        didSet {
            self.tearDownLoadingScreen()
        }
    }
    
    public var tripId: String?
    public var isNewTrip: Bool = true
    
    weak var delegate: UserDelegate?
    
    @IBOutlet weak var tripContainerView: UIView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingScreen(isNewTrip: isNewTrip)
        if isNewTrip {
            AwayGameAPI.createTrip(request: tripRequest) { response in
                self.trip = response
                if let itineraryVC = self.childViewControllers[0] as? ItineraryTableViewController {
                    itineraryVC.trip = self.trip
                    itineraryVC.delegate = self
                    itineraryVC.tripTitle = self.tripTitle
                    itineraryVC.tripRequest = self.tripRequest
                }
            }
        } else {
            AwayGameAPI.getTrip(withId: tripId) { trip in
                self.trip = trip
                if let itineraryVC = self.childViewControllers[0] as? ItineraryTableViewController {
                    itineraryVC.trip = self.trip
                    itineraryVC.tripRequest = self.tripRequest
                    itineraryVC.delegate = self
                    itineraryVC.tripTitle = self.tripTitle
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper.setupNavigationController(self, withTitle: tripTitle ?? "")
    }

    func setupLoadingScreen(isNewTrip: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.hidesBarsOnTap = true
        loadingBackgroundView.alpha = 1.0
        tripContainerView.isHidden = true
        loadingBackgroundView.backgroundColor = Theme.Color.Green.primary
        loadingLabel.text = isNewTrip ? "Building your AwayGame..." : "Getting your AwayGame..."
        loadingLabel.textColor = Theme.Color.white
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo")
        loadingIndicator.color = Theme.Color.white
        loadingIndicator.type = .ballSpinFadeLoader
        loadingIndicator.startAnimating()
        loadingLabel.font = Theme.Font.p1
    }

    func tearDownLoadingScreen() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnTap = false
        UIView.animate(withDuration: 1.0) {
            self.loadingBackgroundView.alpha = 0.0
            self.tripContainerView.isHidden = false
            self.loadingIndicator.stopAnimating()
        }
        
    }

}

// MARK: - User Delegate

extension TripViewController: UserDelegate {
    func user(_ user: User, didSaveTrip trip: Trip, tripRequest: TripRequest?) {
        print("popping TRIP...")
        navigationController?.popViewController(animated: false)
        delegate?.user(user, didSaveTrip: trip, tripRequest: tripRequest)
    }
    
}

