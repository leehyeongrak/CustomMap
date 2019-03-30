//
//  AddViewController.swift
//  CustomMap
//
//  Created by RAK on 28/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import NMapsMap

class AddViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    @IBOutlet weak var mapView: NMFMapView!
    
    @IBOutlet weak var locationInfoContainerView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var locationDescriptionTextView: UITextView!
    
    @IBAction func tappedAddButton(_ sender: UIButton) {
    }
    @IBAction func tappedCancelButton(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
