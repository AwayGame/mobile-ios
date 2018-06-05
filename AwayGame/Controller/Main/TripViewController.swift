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

    public var tripRequest: TripRequest?
    
    @IBOutlet weak var tripContainerView: UIView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingScreen()
        AwayGameAPI.createTrip(request: tripRequest) { response in
            self.tempLabel.text = response
            self.tearDownLoadingScreen()
        }
        
        // Do any additional setup after loading the view.
    }

    func setupLoadingScreen() {
        loadingBackgroundView.alpha = 1.0
        tripContainerView.isHidden = true
        loadingBackgroundView.backgroundColor = Theme.Color.Green.primary
        loadingLabel.text = "Building your AwayGame..."
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo")
        loadingIndicator.color = Theme.Color.white
        loadingIndicator.type = .audioEqualizer
        loadingIndicator.startAnimating()
    }

    func tearDownLoadingScreen() {
        UIView.animate(withDuration: 1.0) {
            self.loadingBackgroundView.alpha = 0.0
            self.tripContainerView.isHidden = false
            self.loadingLabel.text = "Building your AwayGame..."
            self.loadingIndicator.stopAnimating()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
