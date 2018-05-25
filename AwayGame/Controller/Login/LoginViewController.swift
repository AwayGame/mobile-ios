//
//  LoginViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import UIKit

protocol LoginToSignupDelegate: class {
    func didSwitchToSignup()
}

protocol EmailSignInDelegate: class {
    func userDidSignIn()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var tintView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var facebookBackgroundView: UIView!
    @IBOutlet weak var facebookLogoImageView: UIImageView!
    @IBOutlet weak var facebookButtonLabel: UILabel!
    
    @IBOutlet weak var twitterBackgroundView: UIView!
    @IBOutlet weak var twitterLogoImageView: UIImageView!
    @IBOutlet weak var twitterButtonLabel: UILabel!
    
    @IBOutlet weak var emailBackgroundView: UIView!
    @IBOutlet weak var emailLogoImageView: UIImageView!
    @IBOutlet weak var emailButtonLabel: UILabel!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    weak var delegate: LoginToSignupDelegate?
    weak var emailDelegate: EmailSignInDelegate?
    
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
        facebookButtonLabel.text = "Log in with Facebook"
        twitterButtonLabel.text = "Log in with Twitter"
        emailButtonLabel.text = "Log in with Email"
        createAccountButton.setTitle("Don't have an account?", for: .normal)
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
        tintView.alpha = 0.63
        let blur = UIBlurEffect(style: .regular)
        blurView.effect = blur
        
        view.backgroundColor = Theme.Color.Background.darkGray
        styleButtons()
    }
    
    func styleButtons() {
        styleFacebookButton()
        styleTwitterButton()
        styleEmailButton()
    }
    
    func styleFacebookButton() {
        facebookBackgroundView.backgroundColor = Theme.Color.Login.facebook
        facebookBackgroundView.layer.cornerRadius = 5.0
    }
    
    func styleTwitterButton() {
        twitterBackgroundView.backgroundColor = Theme.Color.Login.twitter
        twitterBackgroundView.layer.cornerRadius = 5.0
        twitterBackgroundView.clipsToBounds = true
    }
    
    func styleEmailButton() {
        emailBackgroundView.backgroundColor = Theme.Color.clear
        emailBackgroundView.layer.borderWidth = 2.0
        emailBackgroundView.layer.borderColor = Theme.Color.Login.email.cgColor
        emailBackgroundView.layer.cornerRadius = 5.0
        emailBackgroundView.clipsToBounds = true
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile"], from: self) { (result, error) in
            print("logged in with facebook")
            print(result)
        }
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EmailLoginSegue", sender: self)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        delegate?.didSwitchToSignup()
        print("tapped")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmailLoginSegue" {
            if let emailLoginVC = segue.destination as? EmailLoginViewController {
                emailLoginVC.delegate = self
            }
        }
    }
    
}

// MARK: - EmailLoginDelegate

extension LoginViewController: EmailLoginDelegate {
    func userSignedIn() {
        emailDelegate?.userDidSignIn()
    }
}




