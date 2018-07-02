//
//  TripRequest.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/27/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation

class TripRequest {
    
    public var lat: Double?
    public var long: Double?
    public var preferences: UserPreferences? = UserPreferences()
    public var arrivalTime: String?
    public var departureTime: String?
    public var eventId: String?
    public var eventName: String?
    public var event: Event?
    public var imageUrl: String?
    
}
