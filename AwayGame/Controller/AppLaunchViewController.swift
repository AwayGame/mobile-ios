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
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "hasAccount") {
            getLoginType()
            login()
        } else {
            UserDefaults.standard.set(false, forKey: "hasAccount")
            createAccount()
        }
        
        
    }
    
    // MARK: - Login
    
    func getLoginType() {//} -> LoginType? {
        //return UserDefaults.standard.object(forKey: "login_type")
    }
    
    func login() {
        
    }
    
    func createAccount() {
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
