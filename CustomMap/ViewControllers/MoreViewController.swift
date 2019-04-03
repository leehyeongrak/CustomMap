//
//  MoreViewController.swift
//  CustomMap
//
//  Created by RAK on 03/04/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MoreViewController: UIViewController {

    @IBAction func tappedLogoutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            presentLoginViewController()
        } catch {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Database.database().reference()
            ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                self.navigationItem.title = name
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func presentLoginViewController() {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
            let navigationController = UINavigationController(rootViewController: loginViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }
}
