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
    public var images: [TicketmasterImage]?
    public var date: EventDate?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        longitude <- map["stadium.location.longitude"]
        latitude <- map["stadium.location.latitude"]
        images <- map["images"]
        date <- map["date.start"]
    }
    
    
}

struct EventDate: Mappable {
    
    public var localDate: String?
    public var dateTBD: Bool?
    public var dateTBA: Bool?
    public var timeTBA: Bool?
    public var noSpecificTime: Bool?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        localDate <- map["localDate"]
        dateTBD <- map["dateTBD"]
        dateTBA <- map["dateTBA"]
        timeTBA <- map["timeTBA"]
        noSpecificTime <- map["noSpecificTime"]
    }
    
}


