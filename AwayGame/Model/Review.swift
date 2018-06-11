//
//  Review.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/6/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper

class Review: Mappable {
    
    public var author: String?
    public var authorUrl: String?
    public var language: String?
    public var profilePhotoUrl: String?
    public var rating: Int?
    public var relativeTimeDescription: String?
    public var text: String?
    public var time: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        author <- map["author_name"]
        authorUrl <- map["author_url"]
        language <- map["language"]
        rating <- map["rating"]
        profilePhotoUrl <- map["profile_photo_url"]
        relativeTimeDescription <- map["relative_time_description"]
        text <- map["text"]
        time <- map["time"]
    }
}
