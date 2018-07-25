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
    private var homeViewController: HomeTableViewController?
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var loginContainerView: UIView!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.backgroundColor = Theme.Color.Green.primary
        background.alpha = 1.0
        logoImageView.alpha = 1.0
        mainContainerView.alpha = 0.0
        loginContainerView.alpha = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Firebase Login Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                User.currentUser.email = Auth.auth().currentUser?.email
                User.currentUser.name = Auth.auth().currentUser?.displayName
                User.currentUser.uid = Auth.auth().currentUser?.uid
                User.currentUser.photoUrl = Auth.auth().currentUser?.photoURL?.absoluteString
                
                print("************************")
                print(User.currentUser.uid)
                print("************************")
                
                AwayGameAPI.verifyUser(with: User.currentUser) { user in
                    guard let user = user else {
                        self.proceedToLogin()
                        return
                    }
                    User.currentUser = user
                    if let homeVC = self.homeViewController {
                        homeVC.setupFirebase()
                        homeVC.updateProfileImage()
                    }
                    self.proceedToDashboard()
                }
            } else {
                 self.proceedToLogin()
            }
           
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Login
        
    func proceedToDashboard() {
        mainContainerView.alpha = 1.0
        loginContainerView.alpha = 0.0
        UIView.animate(withDuration: 1.0, animations: {
            self.background.alpha = 0.0
        })
    }
    
    func proceedToLogin() {
        mainContainerView.alpha = 0.0
        loginContainerView.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            self.background.alpha = 0.0
        })
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginEmbedSegue", let loginVC = segue.destination as? LoginViewController  {
            loginVC.signInDelegate = self
        }
        
        if segue.identifier == "HomeEmbedSegue", let navVC = segue.destination as? UINavigationController {
            if let homeVC = navVC.viewControllers.first as? HomeTableViewController {
                homeViewController = homeVC
            }
        }
    }
    
}

// MARK: - EmailSignInDelegate

extension AppLaunchViewController: SignInDelegate {
    func userDidSignIn() {
        background.alpha = 1.0
        proceedToDashboard()
    }
}

// MARK: - HomeDelegate

extension AppLaunchViewController: HomeDelegate {
    func userDidLogout() {
        background.alpha = 1.0
        proceedToLogin()
    }
    
}
