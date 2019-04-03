//
//  SignUpViewController.swift
//  CustomMap
//
//  Created by RAK on 02/04/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        registerUser()
    }
    
    func registerUser() {
        guard let nameText = nameTextField.text, let emailText = emailTextField.text, let passwordText = passwordTextField.text, let passwordConfirmText = passwordConfirmTextField.text else {
            return
        }
        
        if nameText == "" || emailText == "" || passwordText == "" || passwordConfirmText == "" {
            print("Invalid input")
        } else {
            if passwordText == passwordConfirmText {
                Auth.auth().createUser(withEmail: emailText, password: passwordText) { (user, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    let value = ["name": nameText, "email": emailText]
                    if let uid = user?.user.uid {
                        self.registerUserIntoDatabase(uid: uid, value: value)
                    }
                }
            } else {
                print("패스워드가 일치하지 않습니다")
            }
        }
    }
    
    func registerUserIntoDatabase(uid: String, value: [String: Any]) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.updateChildValues(value) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
