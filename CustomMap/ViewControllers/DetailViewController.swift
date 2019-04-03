//
//  DetailViewController.swift
//  CustomMap
//
//  Created by RAK on 28/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import NMapsMap

class DetailViewController: UIViewController {
    
    var place: Place?
    
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationAddressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        if let place = place {
            locationNameLabel.text = place.name
            locationAddressLabel.text = place.roadAddress
            phoneNumberLabel.text = place.phoneNumber
            
            let target = NMGLatLng(lat: Double(place.y)!, lng: Double(place.x)!)
            let position = NMFCameraPosition(target, zoom: 13)
            let cameraUpdate = NMFCameraUpdate(position: position)
            cameraUpdate.animation = NMFCameraUpdateAnimation(rawValue: 2)!
            
            self.mapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = target
            marker.mapView = mapView
        }
    }
}
