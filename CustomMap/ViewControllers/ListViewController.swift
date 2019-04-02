//
//  ListViewController.swift
//  CustomMap
//
//  Created by RAK on 28/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserIsLoggedIn()
    }
    
    func checkUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(presentLoginViewController), with: nil, afterDelay: 0)
        }
    }

    @objc func presentLoginViewController() {
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

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    
    
}
