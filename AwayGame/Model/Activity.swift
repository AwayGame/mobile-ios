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
    public var description: String?
    public var startTime: String?
    public var date: String?
    //public var placeId: String?
    //public var phone: String?
    //public var address: String?
    public var location: Location?
    //public var website: String?
    //public var reviews: [Review]?
    public var rating: Double?
    //public var backups: [Activity]?
    public var photos: [String]?
    public var mapsUrl: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        startTime <- map["startTime"]
        //placeId <- map["placeId"]
        //phone <- map["phone"]
        //address <- map["address"]
        //location <- map["location"]
        //website <- map["website"]
        //reviews <- map["reviews"]
        rating <- map["rating"]
        //subcategory <- map["subcategory"]
        //backups <- map["backups"]
        photos <- map["photos"]
        mapsUrl <- map["mapsUrl"]
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


