//
//  ListViewController.swift
//  CustomMap
//
//  Created by RAK on 28/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListViewController: UIViewController {

    var myPlaces: Array<Place> = []
    var currentUID: String? {
        willSet {
            if newValue != currentUID {
                print("새로운 로그인")
                myPlaces.removeAll()
                fetchPlaces()
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func tappedAddButton(_ sender: UIBarButtonItem) {
        if let addViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddViewController") {
            present(addViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        checkUserIsLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        currentUID = uid
    }
    
    func fetchPlaces() {
        let ref = Database.database().reference().child("places")
        
        ref.observe( .childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                
                if dictionary["uid"] as? String == self.currentUID {
                    let place = Place(place: dictionary["place"] as! NSDictionary)
                    self.myPlaces.append(place)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
            
        }, withCancel: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let index = indexPath.row
            vc.place = myPlaces[index]
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myPlaces.count)
        return myPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        let place = myPlaces[indexPath.row]
        cell.locationNameLabel.text = place.name
        cell.locationAddressLabel.text = place.roadAddress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    
}

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    
    
}
