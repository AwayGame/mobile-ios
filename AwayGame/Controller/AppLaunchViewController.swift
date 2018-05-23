//
//  AppLaunchViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//


import FirebaseAuth
import UIKit

class AppLaunchViewController: UIViewController {

    private var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var signupContainerView: UIView!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func hideAllContainers() {
        logoImageView.isHidden = true
        mainContainerView.isHidden = true
        loginContainerView.isHidden = true
        signupContainerView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Login
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                
            User.currentUser.email = Auth.auth().currentUser?.email
            User.currentUser.name = Auth.auth().currentUser?.displayName
            User.currentUser.uid = Auth.auth().currentUser?.uid

            AwayGameAPI.verifyUser(with: User.currentUser)
            self.proceedToHome()
                
            } else {
                if UserDefaults.isFirstLaunch() {
                    self.proceedToSignup()
                } else {
                    self.proceedToLogin()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Login
    
    func getLoginType() {//} -> LoginType? {
        //return UserDefaults.standard.object(forKey: "login_type")
    }
    
    func proceedToHome() {
        hideAllContainers()
        mainContainerView.frame.origin.y -= 20.0
        mainContainerView.isHidden = false
        UIView.transition(with: mainContainerView, duration: 1.5, options: .transitionCrossDissolve, animations: {
            self.mainContainerView.frame.origin.y += 20.0
        }, completion: nil)
    }
    
    func proceedToLogin() {
        hideAllContainers()
        loginContainerView.frame.origin.y -= 20.0
        loginContainerView.isHidden = false
        UIView.transition(with: loginContainerView, duration: 1.5, options: .transitionCrossDissolve, animations: {
            self.loginContainerView.frame.origin.y += 20.0
        }, completion: nil)
    }
    
    func proceedToSignup() {
        hideAllContainers()
        signupContainerView.frame.origin.y -= 20.0
        signupContainerView.isHidden = false
        UIView.transition(with: signupContainerView, duration: 1.5, options: .transitionCrossDissolve, animations: {
            self.signupContainerView.frame.origin.y += 20.0
        }, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginEmbedSegue", let loginVC = segue.destination as? LoginViewController  {
            loginVC.delegate = self
        }
        
        if segue.identifier == "SignupEmbedSegue", let signupVC = segue.destination as? SignupViewController  {
            signupVC.delegate = self
        }
    }
    
}

// MARK: - LoginToSignupDelegate

extension AppLaunchViewController: LoginToSignupDelegate {
    func didSwitchToSignup() {
        proceedToSignup()
    }
}

// MARK: - SignuptoLoginDelegate

extension AppLaunchViewController: SignupToLoginDelegate {
    func didSwitchToLogin() {
        proceedToLogin()
    }
}
