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
    
    private var homeViewController: HomeTableViewController?
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var loginContainerView: UIView!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func hideAllContainers() {
        logoImageView.isHidden = true
        mainContainerView.isHidden = true
        loginContainerView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Firebase Login Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                User.currentUser.email = Auth.auth().currentUser?.email
                User.currentUser.name = Auth.auth().currentUser?.displayName
                User.currentUser.uid = Auth.auth().currentUser?.uid
                User.currentUser.photoUrl = Auth.auth().currentUser?.photoURL?.absoluteString
                
                AwayGameAPI.verifyUser(with: User.currentUser) {user in
                    User.currentUser = user
                    print(User.currentUser.photoUrl)
                    print(User.currentUser.name)
                    if let homeVC = self.homeViewController {
                        print("HERE")
                        homeVC.setupFirebase()
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
        hideAllContainers()
        mainContainerView.isHidden = false
        UIView.transition(with: mainContainerView, duration: 1.0, options: .transitionCrossDissolve, animations: {
        }, completion: nil)
    }
    
    func proceedToLogin() {
        hideAllContainers()
        loginContainerView.isHidden = false
        UIView.transition(with: loginContainerView, duration: 1.0, options: .transitionCrossDissolve, animations: {
        }, completion: nil)
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
        proceedToDashboard()
    }
}

// MARK: - HomeDelegate

extension AppLaunchViewController: HomeDelegate {
    func userDidLogout() {
        proceedToLogin()
    }
    
}
