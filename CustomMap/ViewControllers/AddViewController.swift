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
    
    var locationSearchResult: LocationSearchResult?
    var locationSearchResults: Array<Location> = []
    
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
        resultTableView.delegate = self
        resultTableView.dataSource = self
        searchTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchLocation(keyword: String, completion: @escaping (LocationSearchResult) -> ()) {
        let baseURL = "https://naveropenapi.apigw.ntruss.com/map-place/v1/search?query=\(keyword)&coordinate=127.1054328,37.3595963"
        let searchURL = baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: searchURL!) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("yxogg3rjrj", forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.setValue("P31rSw6Lr80xzOwowzwqK5BRnmtlZdtICLtmoZ96", forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return
                }
                guard let searchData = String(data: data!, encoding: .utf8) else {
                    return
                }
                print(searchData)
                
                if let jsonData = searchData.data(using: .utf8) {
                    let result = try! JSONDecoder().decode(LocationSearchResult.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
            }
            task.resume()
        }
    }

}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = locationSearchResult {
            return result.places.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        cell.textLabel?.text = locationSearchResult?.places[indexPath.row].name
        cell.detailTextLabel?.text = locationSearchResult?.places[indexPath.row].roadAddress
        return cell
    }
    
    
}

extension AddViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            searchLocation(keyword: text) { (result) in
                self.locationSearchResult = result
                self.resultTableView.reloadData()
            }
        }
        self.view.endEditing(true)
        return true
    }
}
