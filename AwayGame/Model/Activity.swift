//
//  Activity.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/7/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class Activity: Mappable {
    
    public var category: String?
    public var date: String?
    public var location: Location?
    
    var isGame: Bool {
        return category == "game"
    }
    
    var isYelp: Bool {
        return provider == "yelp"
    }
    
    // MARK: - Activity
    
    public var name: String?
    public var description: String?
    public var startTime: String?
    public var placeId: String?
    public var phone: String?
    public var address: String?
    public var website: String?
    public var reviews: [Review]?
    public var rating: Double?
    public var backups: [Activity]?
    public var photos: [String]?
    public var mapsUrl: String?
    public var needsUber: Bool?
    public var subCategory: String?
    public var provider: String?
    
    // MARK: - Game
    
    public var title: String?
    public var classification: String?
    public var id: String?
    public var ticketUrl: String?
    public var timeToBeAtStadium: String?
    public var isTBA: Bool?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        date <- map["date"]
        startTime <- map["startTime"]
        placeId <- map["placeId"]
        phone <- map["phone"]
        address <- map["address"]
        location <- map["location"]
        website <- map["website"]
        reviews <- map["reviews"]
        rating <- map["rating"]
        backups <- map["backups"]
        photos <- map["photos"]
        mapsUrl <- map["mapsUrl"]
        category <- map["category"]
        needsUber <- map["needsUber"]
        classification <- map["classification"]
        id <- map["id"]
        ticketUrl <- map["ticketUrl"]
        isTBA <- map["isTBA"]
        
    }
    
    var displayImage: String? {
        guard let photos = photos else { return "" }
        return photos.count > 0 ? photos.first : ""
    }

}

// MARK: - Location

struct Location: Mappable {
        
    public var latitude: Double?
    public var longitude: Double?
        
    init?(map: Map) {}
        
    mutating func mapping(map: Map) {
            latitude <- map["lat"]
            longitude <- map["long"]
    }
    
}


