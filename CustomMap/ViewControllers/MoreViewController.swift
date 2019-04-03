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
        
        let email = Auth.auth().currentUser?.email
        self.navigationItem.title = email
        // Do any additional setup after loading the view.
    }
    
    func presentLoginViewController() {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
            let navigationController = UINavigationController(rootViewController: loginViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
