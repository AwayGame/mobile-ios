//
//  SignupViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/17/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FBSDKCoreKit
import FirebaseAuth
import UIKit

protocol SignupToLoginDelegate: class {
    func didSwitchToLogin()
}

class SignupViewController: UIViewController {
    
    let gradient = CAGradientLayer()
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var facebookBackgroundView: UIView!
    @IBOutlet weak var facebookLogoImageView: UIImageView!
    @IBOutlet weak var facebookButtonLabel: UILabel!
    
    @IBOutlet weak var twitterBackgroundView: UIView!
    @IBOutlet weak var twitterLogoImageView: UIImageView!
    @IBOutlet weak var twitterButtonLabel: UILabel!
    
    @IBOutlet weak var emailBackgroundView: UIView!
    @IBOutlet weak var emailLogoImageView: UIImageView!
    @IBOutlet weak var emailButtonLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!

    weak var delegate: SignupToLoginDelegate?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.current() != nil) {
            print("User is logged in")
        }
        
        setupViews()
        styleViews()
    }
    
    func setupViews() {
        gradientView.layer.addSublayer(gradient)
        setupLabels()
        setupImages()
    }
    
    func setupLabels() {
        facebookButtonLabel.text = "Sign up with Facebook"
        twitterButtonLabel.text = "Sign up with Twitter"
        emailButtonLabel.text = "Sign up with Email"
        loginButton.setTitle("Already have an account?", for: .normal)
    }
    
    func setupImages() {
        //backgroundImageView.image = ...
        //logoImageView.image = ...
        //facebookLogoImageView.image = ...
        //twitterLogoImageView.image = ...
        //emailLogoImageView.image = ...
    }
    
    // MARK: - Styling
    
    func styleViews() {
        styleGradient()
        styleButtons()
    }
    
    func styleGradient() {
        gradient.frame = view.frame
        gradient.colors = [Theme.Color.Gradient.green, Theme.Color.Gradient.blue]
        gradient.locations = [0.0, 1.0]
    }
    
    func styleButtons() {
        facebookBackgroundView.backgroundColor = Theme.Color.Login.facebook
        twitterBackgroundView.backgroundColor = Theme.Color.Login.twitter
        emailBackgroundView.backgroundColor = Theme.Color.clear
        emailBackgroundView.layer.borderWidth = 1.0
        emailBackgroundView.layer.borderColor = Theme.Color.Login.email.cgColor
    }
    
    // MARK: - Actions
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {

    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        delegate?.didSwitchToLogin()
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
