//
//  ErrorManager.swift
//  AwayGame
//
//  Created by Blake Swaidner on 7/10/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit

class ErrorManager {
    
    // MARK: - Validation
    
    class func emailIsInvalid(_ email :String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return !emailTest.evaluate(with: email)
    }
    
    
    // MARK: - Alerts
    
    static let noGamesAlert: AGAlertController = {
        let alert = AGAlertController(title: "No Games Found", message: "No games found on selected dates.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    static let incorrectPasswordAlert: AGAlertController = {
        let alert = AGAlertController(title: "Incorrect Password", message: "The password you entered was incorrect. Please try again.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    static let emailInvalidAlert: AGAlertController = {
        let alert = AGAlertController(title: "Email Invalid", message: "The email you entered does is not valid. Please try again.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    static let noAccountFound: AGAlertController = {
        let alert = AGAlertController(title: "No Account Found", message: "There is no account associated with this email address. Please try again.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    static let accountAlreadyExists: AGAlertController = {
        let alert = AGAlertController(title: "Account Already Exists", message: "An account with this email address already exists. Please use another email.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    static let passwordsDoNotMatch: AGAlertController = {
        let alert = AGAlertController(title: "Passwords do not match.", message: "Please check that the passwords you entered are the same.", preferredStyle: .alert)
        alert.addAction(ErrorManager.okAction)
        return alert
    }()
    
    
    // MARK: - Actions
        
    static let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    
}
