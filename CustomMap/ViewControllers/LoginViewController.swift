//
//  LoginViewController.swift
//  CustomMap
//
//  Created by RAK on 02/04/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func tappedSignInButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return
        }
        
        if emailText == "" || passwordText == "" {
            print("Invalid input")
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error != nil {
                    print(error!)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
