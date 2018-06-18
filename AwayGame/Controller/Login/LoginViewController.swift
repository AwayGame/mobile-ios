//
//  LoginViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import TwitterKit
import TwitterCore
import UIKit

protocol SignInDelegate: class {
    func userDidSignIn()
}

class LoginViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    let facebookSDKButton = FBSDKLoginButton()
    @IBOutlet weak var facebookLoginButton: UIButton!
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
    
    weak var signInDelegate: SignInDelegate?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleViews()
        facebookSDKButton.delegate = self
    }

    func setupViews() {
        setupLabels()
        setupImages()
    }
    
    func setupLabels() {
        facebookButtonLabel.text = "Log in with Facebook"
        twitterButtonLabel.text = "Log in with Twitter"
        emailButtonLabel.text = "Log in with Email"
        createAccountButton.setTitle("Create Account", for: .normal)
    }
    
    func setupImages() {
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo-Large")
        facebookLogoImageView.image = #imageLiteral(resourceName: "flogo-HexRBG-Wht-114")
        twitterLogoImageView.image = #imageLiteral(resourceName: "Twitter_Social_Icon_Rounded_Square_White")
        emailLogoImageView.image = #imageLiteral(resourceName: "email")
        emailLogoImageView.tintColor = Theme.Color.white
    }
    
    // MARK: - Styling
    
    func styleViews() {
        for buttonView in [facebookBackgroundView, twitterBackgroundView, emailBackgroundView] {
            buttonView?.layer.cornerRadius = 5.0
            buttonView?.clipsToBounds = true
            
        }
        for label in [facebookButtonLabel, twitterButtonLabel, emailButtonLabel, createAccountButton.titleLabel] {
            label?.font = Theme.Font.p1
        }
        facebookBackgroundView.backgroundColor = Theme.Color.Login.facebook
        twitterBackgroundView.backgroundColor = Theme.Color.Login.twitter
        emailBackgroundView.backgroundColor = Theme.Color.clear
        emailBackgroundView.layer.borderWidth = 2.0
        emailBackgroundView.layer.borderColor = Theme.Color.Login.email.cgColor
        createAccountButton.setTitleColor(Theme.Color.white, for: .normal)
        createAccountButton.setTitleColor(Theme.Color.Background.primary, for: .highlighted)
        
    }
    
    // MARK: - Actions
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        facebookSDKButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        Twitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    if (email != nil) {
                        print("signed in as \(session?.userName)");
                    } else {
                        print("error: \(error?.localizedDescription)");
                    }
                }
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
    }

    @IBAction func emailButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "EmailLoginSegue", sender: self)
    }
        
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateAccountSegue", sender: self)
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
        signInDelegate?.userDidSignIn()
    }
    
}

// MARK: - FBSDKLoginButtonDelegate

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // TODO: - Error when user taps cancel on facebook button
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("User signed in")
            self.signInDelegate?.userDidSignIn()
        }
    }
    
}
