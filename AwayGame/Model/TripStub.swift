//
//  TripStub.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class TripStub: Mappable {
    
    public var title: String?
    public var id: String?
    public var imageUrl: String?
    public var isCompleted: Bool?
    public var startDate: String?
    public var createdAt: String?
    public var isDeleted: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
        imageUrl <- map["imageUrl"]
        isCompleted <- map["completed"]
        startDate <- map["startDate"]
        createdAt <- map["createdAt"]
        isDeleted <- map["deleted"]
    }
    
}
