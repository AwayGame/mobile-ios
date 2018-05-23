//
//  LoginViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FBSDKCoreKit
import FirebaseAuth
import UIKit

protocol LoginToSignupDelegate: class {
    func didSwitchToSignup()
}

class LoginViewController: UIViewController {

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
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    weak var delegate: LoginToSignupDelegate?
    
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
        tintView.alpha = 0.6
        styleButtons()
    }
    
    func styleButtons() {
        styleFacebookButton()
        styleTwitterButton()
        styleEmailButton()
    }
    
    func styleFacebookButton() {
        facebookBackgroundView.backgroundColor = Theme.Color.Login.facebook
        facebookBackgroundView.layer.cornerRadius = 10.0
        facebookBackgroundView.clipsToBounds = true
    }
    
    func styleTwitterButton() {
        twitterBackgroundView.backgroundColor = Theme.Color.Login.twitter
        twitterBackgroundView.layer.cornerRadius = 10.0
        twitterBackgroundView.clipsToBounds = true
    }
    
    func styleEmailButton() {
        emailBackgroundView.backgroundColor = Theme.Color.clear
        emailBackgroundView.layer.borderWidth = 2.0
        emailBackgroundView.layer.borderColor = Theme.Color.Login.email.cgColor
        emailBackgroundView.layer.cornerRadius = 10.0
        emailBackgroundView.clipsToBounds = true
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "hasAccount") {
            if UserDefaults.standard.string(forKey: "accountType") == "email" {
                performSegue(withIdentifier: "EmailLoginSegue", sender: self)
            }
        } else {
            
            let email = "anonymoususer123@gmail.com"
            let password = "12341234"
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if error != nil {
                    
                } else {
                    print("User Signed in.")
                    
                }
                
            }
            

        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        delegate?.didSwitchToSignup()
        print("tapped")
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
