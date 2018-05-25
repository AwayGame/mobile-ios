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
    
    @IBOutlet weak var tintView: UIView!
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
        setupViews()
        styleViews()
    }
    
    func setupViews() {
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
        backgroundImageView.image = #imageLiteral(resourceName: "signup-login background")
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo-Large")
        facebookLogoImageView.image = #imageLiteral(resourceName: "flogo-HexRBG-Wht-114")
        twitterLogoImageView.image = #imageLiteral(resourceName: "Twitter_Social_Icon_Rounded_Square_White")
        emailLogoImageView.image = #imageLiteral(resourceName: "email")
        emailLogoImageView.tintColor = Theme.Color.white
    }
    
    // MARK: - Styling
    
    func styleViews() {
        tintView.backgroundColor = Theme.Color.Green.primary
        tintView.alpha = 0.6
        styleButtons()
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
        signupWithFacebook()
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        signupWithTwitter()
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EmailSignUpSegue", sender: self)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        delegate?.didSwitchToLogin()
    }
    
    // MARK: - Facebook
    
    func signupWithFacebook() {
        
    }
    
    
    // MARK: - Twitter
    
    func signupWithTwitter() {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmailSignUpSegue" {
            if let emailNameVC = segue.destination as? EmailNameViewController {
                // set delegate
            }
        }
    }
 
    
}
