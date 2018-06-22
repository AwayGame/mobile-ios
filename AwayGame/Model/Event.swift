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
    public var date: String?
    public var images: [TicketmasterImage]?
    public var time: String?
    public var ticketUrl: String?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        ticketUrl <- map["ticketUrl"]
        id <- map["id"]
        images <- map["images"]
        date <- map["date"]
        time <- map["time"]
    }

}


