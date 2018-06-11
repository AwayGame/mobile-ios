//
//  Trip.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper
import Foundation

class Trip: Mappable {
    
    public var itineraries: [Itinerary]?
    public var preferences: TripRequest?
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        itineraries <- map["itineraries"]
        preferences <- map["preferencesUsed"]
    }
    
}
