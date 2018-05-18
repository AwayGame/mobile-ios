//
//  Activity.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class Activity: Mappable {
    
    public var name: String?
    public var placeId: String?
    public var phone: String?
    public var address: String?
    public var location: Location?
    public var hours: Hours?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        placeId <- map["placeId"]
        phone <- map["phone"]
        address <- map["address"]
        location <- map["location"]
        hours <- map["hours"]
    }
    
}

// MARK: - Location

struct Location: Mappable {
        
    public var latitude: Double?
    public var longitude: Double?
    public var mapsUrl: String?
        
    init?(map: Map) {}
        
    mutating func mapping(map: Map) {
            latitude <- map["lat"]
            longitude <- map["long"]
            mapsUrl <- map["mapsUrl"]
    }
    
}

struct Hours: Mappable {
    
    public var formattedHours: [String]?
    public var individualDaysData: [DayHours]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        formattedHours <- map["formattedHours"]
    }
    
}

struct DayHours: Mappable {
    
    public var open: OpenClose?
    public var close: OpenClose?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        open <- map["open"]
        close <- map["close"]
    }
    
}

struct OpenClose: Mappable {
    
    public var day: Int?
    public var time: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        day <- map["day"]
        time <- map["time"]
    }
    
}
