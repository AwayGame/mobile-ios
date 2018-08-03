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
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
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
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                guard let err = AuthErrorCode(rawValue: error!._code) else { return }
                switch err {
                case .userNotFound:
                    self.present(ErrorManager.noAccountFound, animated: true, completion: nil)
                case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                    self.present(ErrorManager.emailInvalidAlert, animated: true, completion: nil)
                case .wrongPassword:
                    self.present(ErrorManager.incorrectPasswordAlert, animated: true, completion: nil)
                default:
                    return
                }
            } else {
                print("User Signed in.")
                self.delegate?.userSignedIn()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {
            // TODO: Error Handling
            self.present(ErrorManager.emailInvalidAlert, animated: true, completion: nil)
            return
        }
        
        if ErrorManager.emailIsInvalid(email) {
            self.present(ErrorManager.emailInvalidAlert, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordTextField.text else {
        
            print("Password text field is empty")
            self.present(ErrorManager.incorrectPasswordAlert, animated: true, completion: nil)
            return
        }
        
        
        
        login(withEmail: email, password: password)
    }

}

extension EmailLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
