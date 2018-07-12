//
//  EmailSignupViewController.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/18/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol EmailSignupDelegate: class {
    func userDidSignup()
}

enum SignupState {
    case name
    case email
    case password
}

class EmailSignupViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topTextFieldLabel: UILabel!
    @IBOutlet weak var bottomTextFieldLabel: UILabel!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Constraints
    
    @IBOutlet weak var logoImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextFieldLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomUnderlineViewHeightConstraint: NSLayoutConstraint!
    
    private var name: String?
    private var email: String?
    private var password: String?
    private var state: SignupState = .name {
        didSet {
            configureViews()
        }
    }
    
    weak var delegate: EmailSignupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        styleViews()
    }
    
    func configureViews() {
        switch state {
        case .name:
            AGAnalytics.logEvent(.emailSignupFirstPageDidDisplay, parameters: nil)
            configureNameViews()
        case .email:
            AGAnalytics.logEvent(.emailSignupSecondPageDidDisplay, parameters: nil)
            configureEmailViews()
        case .password:
            AGAnalytics.logEvent(.emailSignupThirdPageDidDisplay, parameters: nil)
            configurePasswordViews()
        }
    
        doneButton.setTitle("Next", for: .normal)
        cancelButton.setTitle("✕", for: .normal)
        backgroundImageView.image = #imageLiteral(resourceName: "login-background")
        
        // Shrink logo if not iPhone X or plus sized device
        if UIScreen.main.bounds.height < 736.0 {
            logoImageViewWidthConstraint.constant = 96.0
            logoImageViewHeightConstraint.constant = 96.0
        }
    }
    
    
    func configureNameViews() {
        titleLabel.text = "What's your name?"
        topTextField.text = ""
        bottomTextField.text = ""
        topTextFieldLabel.text = "First Name"
        topTextField.autocapitalizationType = .words
        bottomTextField.autocapitalizationType = .words
        bottomTextFieldLabel.text = "Last Name"
    }
    
    func configureEmailViews() {
        titleLabel.text = "How about your email?"
        topTextField.text = ""
        bottomTextField.text = ""
        topTextFieldLabel.text = "Email"
        bottomTextFieldLabel.text = ""
    }
    
    func configurePasswordViews() {
        titleLabel.text = "Almost there, pick a password!"
        topTextFieldLabel.text = "Password"
        topTextField.text = ""
        bottomTextField.text = ""
        topTextField.isSecureTextEntry = true
        bottomTextFieldLabel.text = "Confirm Password"
        bottomTextField.isSecureTextEntry = true
        doneButton.setTitle("Sign Up", for: .normal)
    }
    
    
    // MARK: - Styling
    
    func styleViews() {
        // TODO: Will be cleaned up with custom views/labels, etc.
        titleLabel.font = Theme.Font.h1
        titleLabel.textColor = Theme.Color.white
        topTextFieldLabel.font = Theme.Font.p1
        bottomTextFieldLabel.font = Theme.Font.p1
        cancelButton.titleLabel?.font = Theme.Font.h1
        doneButton.titleLabel?.font = Theme.Font.p1
        topTextFieldLabel.textColor = Theme.Color.white
        bottomTextFieldLabel.textColor = Theme.Color.white
        cancelButton.setTitleColor(Theme.Color.white, for: .normal)
        doneButton.setTitleColor(Theme.Color.white, for: .normal)
        topTextField.tintColor = Theme.Color.white
        bottomTextField.tintColor = Theme.Color.white
        topTextField.textColor = Theme.Color.white
        bottomTextField.textColor = Theme.Color.white
        topTextField.font = Theme.Font.p1
        bottomTextField.font = Theme.Font.p1
    }
    
    func signup(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                // TODO: Handle errors here
                print(error)
            } else {
                print("User Signed up.")
                self.delegate?.userDidSignup()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        switch state {
        case .name:
            guard let firstName = topTextField.text else { return }
            guard let lastName = bottomTextField.text else { return }
            self.name = "\(firstName) \(lastName)"
            
            UIView.animate(withDuration: 1.0, animations: {
                self.bottomTextFieldHeightConstraint.constant = 0.0
                self.bottomTextFieldLabelHeightConstraint.constant = 0.0
                self.bottomUnderlineViewHeightConstraint.constant = 0.0
            }, completion: { (completed) in
                self.state = .email
            })
            
        case .email:
            guard let email = topTextField.text else { return }
            self.email = email
            
            UIView.animate(withDuration: 1.0, animations: {
                self.bottomTextFieldHeightConstraint.constant = 24.0
                self.bottomTextFieldLabelHeightConstraint.constant = 18.0
                self.bottomUnderlineViewHeightConstraint.constant = 1.0
            }, completion: { (completed) in
                self.state = .password
            })
            
        case .password:
            guard let password = topTextField.text else { return }
            guard let confirmedPassword = bottomTextField.text else { return }
            if password == confirmedPassword {
                self.password = password
            }
            guard let email = email else { return }
            signup(withEmail: email, password: password)
            
            self.delegate?.userDidSignup()
            self.dismiss(animated: true, completion:nil)
        }
        
    }
    
    
}
