//
//  User.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import ObjectMapper
import Foundation


protocol UserDelegate: class {
    func user(_ user: User, didSaveTrip trip: Trip)
}


final class User: Mappable {
    
    static var currentUser = User()
    
    public var name: String?
    public var email: String?
    public var photoUrl: String?
    public var uid: String?
    public var tripIds: [String]?
    public var preferences: Preferences?
    public var tripStubs: [TripStub]?
    private init() {}
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        photoUrl <- map["photoUrl"]
        uid <- map["uid"]
        preferences <- map["preferences"]
        tripStubs <- map["tripStubs"]
    }
    
}

