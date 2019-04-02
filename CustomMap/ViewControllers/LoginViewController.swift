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
            print("필드를 입력해주세요")
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                print("유우저 \(user)")
                if error != nil {
                    print(error!)
                }
//                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
