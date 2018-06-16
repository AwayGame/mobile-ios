//
//  TicketmasterImage.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/12/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import ObjectMapper

class TicketmasterImage: Mappable {
    
    public var ratio: String?
    public var url: String?
    public var width: Int?
    public var height: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ratio <- map["ratio"]
        url <- map["url"]
        width <- map["width"]
        height <- map["height"]
    }
    
    
}
