//
//  Game.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/11/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class Event: Mappable {

    public var name: String?
    public var id: String?
    public var longitude: String?
    public var latitude: String?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        longitude <- map["stadium.location.longitude"]
        latitude <- map["stadium.location.latitude"]
    }
    
    
}
