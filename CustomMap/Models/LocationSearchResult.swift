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
