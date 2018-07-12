//
//  EmailLoginViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import FirebaseAuth
import UIKit

protocol EmailLoginDelegate: class {
    func userSignedIn()
}

class EmailLoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var logoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: EmailLoginDelegate?
    
    override func viewDidLoad() {
        print(UIScreen.main.bounds.height)
        super.viewDidLoad()
        configureViews()
        styleViews()
    }
    
    func configureViews () {
        emailLabel.text = "Email"
        passwordLabel.text = "Password"
        forgotPasswordButton.setTitle("Forgot Password", for: .normal)
        passwordTextField.isSecureTextEntry = true
        doneButton.setTitle("Log in", for: .normal)
        cancelButton.setTitle("✕", for: .normal)
        backgroundImageView.image = #imageLiteral(resourceName: "login-background")
        
        // Shrink logo if not iPhone X or plus sized device
        if UIScreen.main.bounds.height < 736.0 {
            logoImageViewWidthConstraint.constant = 112.0
            logoImageViewHeightConstraint.constant = 112.0
        }
    }
    
    // MARK: - Styling
    
    func styleViews() {
        // TODO: Will be cleaned up with custom views/labels, etc.
        emailLabel.font = Theme.Font.p1
        passwordLabel.font = Theme.Font.p1
        cancelButton.titleLabel?.font = Theme.Font.h1
        doneButton.titleLabel?.font = Theme.Font.p1
        emailLabel.textColor = Theme.Color.white
        passwordLabel.textColor = Theme.Color.white
        cancelButton.setTitleColor(Theme.Color.white, for: .normal)
        doneButton.setTitleColor(Theme.Color.white, for: .normal)
        emailTextField.tintColor = Theme.Color.white
        passwordTextField.tintColor = Theme.Color.white
        emailTextField.textColor = Theme.Color.white
        passwordTextField.textColor = Theme.Color.white
        emailTextField.font = Theme.Font.p1
        passwordTextField.font = Theme.Font.p1
        forgotPasswordButton.setTitleColor(Theme.Color.white, for: .normal)
        forgotPasswordButton.titleLabel?.font = Theme.Font.p1
    }
    
    func login(withEmail email: String, password: String) {

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                // TODO: Handle errors here
                print(error)
            } else {
                print("User Signed in.")
                self.delegate?.userSignedIn()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    // @IBActions
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let forgotPasswordAlert = UIAlertController(title: "Forgot password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email..."
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            guard let resetEmail = forgotPasswordAlert.textFields?.first?.text else { return }
            Auth.auth().sendPasswordReset(withEmail: resetEmail, completion: { (error) in
                if error != nil{
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "There was an error sending your password. Please try again.", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }else {
                    let resetEmailSentAlert = UIAlertController(title: "Success", message: "Check your email to reset your password.", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }))
        //PRESENT ALERT
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {
            // TODO: Error Handling
            print("Email text field is empty")
            return
        }
        
        guard let password = passwordTextField.text else {
            // TODO: Error Handling
            print("Password text field is empty")
            return
        }
        
        login(withEmail: email, password: password)
    }


}
