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

protocol LoginToSignupDelegate: class {
    func didSwitchToSignup()
}

protocol SignInDelegate: class {
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
    weak var signInDelegate: SignInDelegate?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleViews()
        facebookLoginButton.delegate = self
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
        logoImageView.image = #imageLiteral(resourceName: "AwayGameLogo-Large")
        facebookLogoImageView.image = #imageLiteral(resourceName: "flogo-HexRBG-Wht-114")
        twitterLogoImageView.image = #imageLiteral(resourceName: "Twitter_Social_Icon_Rounded_Square_White")
        emailLogoImageView.image = #imageLiteral(resourceName: "email")
        emailLogoImageView.tintColor = Theme.Color.white
    }
    
    // MARK: - Styling
    
    func styleViews() {
        facebookButtonLabel.font = Theme.Font.h1
        twitterButtonLabel.font = Theme.Font.h1
        emailButtonLabel.font = Theme.Font.h1

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
        print("facebook tapped")
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
