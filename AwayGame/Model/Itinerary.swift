//
//  Itinerary.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class Itinerary: Mappable {
    
    public var activities: [Activity]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        activities <- map["activities"]
    }

}
