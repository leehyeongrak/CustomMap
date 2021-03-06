//
//  Location.swift
//  CustomMap
//
//  Created by RAK on 31/03/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import Foundation

struct LocationSearchResult: Codable {
    var status: String
    var meta: Meta
    var places: Array<Place>
    var errorMessage: String
}

struct Meta: Codable {
    var totalCount: Int
    var count: Int
}

struct Place: Codable {
    var name: String
    var roadAddress: String
    var jibunAddress: String
    var phoneNumber: String
    var x: String
    var y: String
    var distance: Double
    var sessionId: String
    
    var dictionary: [String: Any] {
        return ["name": name,
                "roadAddress": roadAddress,
                "jibunAddress": jibunAddress,
                "phoneNumber": phoneNumber,
                "x": x,
                "y": y,
                "distance": distance,
                "sessionId": sessionId]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case roadAddress = "road_address"
        case jibunAddress = "jibun_address"
        case phoneNumber = "phone_number"
        case x
        case y
        case distance
        case sessionId
    }
}

extension Place {
    init(place : NSDictionary){
        name = place["name"] as? String ?? ""
        roadAddress = place["roadAddress"] as? String ?? ""
        jibunAddress = place["jibunAddress"] as? String ?? ""
        phoneNumber = place["phoneNumber"] as? String ?? ""
        x = place["x"] as? String ?? ""
        y = place["y"] as? String ?? ""
        distance = place["distance"] as? Double ?? 0
        sessionId = place["sessionId"] as? String ?? ""
    }
}
