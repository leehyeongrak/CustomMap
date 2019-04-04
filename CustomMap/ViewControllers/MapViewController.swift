//
//  MapViewController.swift
//  CustomMap
//
//  Created by RAK on 28/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import NMapsMap
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController {

    var selectedPlace: Place?
    
    var myPlaces: Array<Place> = []
    var markers: Array<NMFMarker> = []
    let infoWindow = NMFInfoWindow()
    
    var currentUID: String? {
        willSet {
            if newValue != currentUID {
                print("새로운 로그인")
                myPlaces.removeAll()
                fetchPlaces()
            }
        }
    }
    
    @IBOutlet weak var mapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    self.markOnMapView(places: self.myPlaces)
                    self.mapView.moveCamera(NMFCameraUpdate(zoomTo: 7))
                }
            }
            
            
            
        }, withCancel: nil)
    }
    
    func markOnMapView(places: Array<Place>) {
        
        let handler: NMFOverlayTouchHandler = { [weak self] (overlay) -> Bool in
            
            if let marker = overlay as? NMFMarker {
                if marker.infoWindow == nil {
                    let dataSource = NMFInfoWindowDefaultTextSource.data()
                    dataSource.title = marker.userInfo["title"] as! String
                    self?.infoWindow.dataSource = dataSource
                    self?.infoWindow.open(with: marker)
                    self?.selectedPlace = marker.userInfo["place"] as! Place
                    DispatchQueue.main.async {
                        self?.cameraMoveToSelectedLocation()
                    }
                } else {
                    self?.infoWindow.close()
                }
            }
            return true
        };
        
        for marker in markers {
            marker.mapView = nil
        }
        
        markers.removeAll()
        
        for (index, place) in places.enumerated() {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: Double(place.y)!, lng: Double(place.x)!)
            marker.userInfo = ["title": place.name, "place": place, "index": index]
            markers.append(marker)
        }
        
        for marker in markers {
            marker.touchHandler = handler
            marker.mapView = mapView
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        currentUID = uid
    }
    
    func cameraMoveToSelectedLocation() {
        let lat = Double((selectedPlace?.y)!)
        let lng = Double((selectedPlace?.x)!)
        let target = NMGLatLng(lat: lat!, lng: lng!)
        let position = NMFCameraPosition(target, zoom: 13)
        let cameraUpdate = NMFCameraUpdate(position: position)
        cameraUpdate.animation = NMFCameraUpdateAnimation(rawValue: 2)!
        self.mapView.moveCamera(cameraUpdate)
    }
}
