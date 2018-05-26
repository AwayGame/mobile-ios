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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    weak var delegate: EmailLoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login(withEmail: String?, password: String?) {
        guard let email = withEmail else {
            // TODO: Handle errors here
            return
        }
        guard let password = password else {
            // TODO: Handle errors here
            return
        }
        
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
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
