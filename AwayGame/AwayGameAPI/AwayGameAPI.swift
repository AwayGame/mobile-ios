//
//  AwayGameAPI.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

final class AwayGameAPI {
    
    class func verifyUser(with user: User) {

        // TODO: Make closure/callback for verify user
        
        let parameters: [String: Any] = [
            "name": user.name ?? "",
            "photoUrl": user.photoUrl ?? "",
            "email": user.email ?? "",
            "uid": user.uid ?? ""
        ]
        
        Alamofire.request(Router.verifyUser(parameters: parameters)).responseObject { (response: DataResponse<User>) in
            
            print(response.result.value)
            guard let user = response.result.value else {
                print("ERROR")
                return
            }
            
            User.currentUser = user
            initializeDatabaseSubscription()
            print(User.currentUser.photoUrl)
            print(User.currentUser.name)

        }
    }
    
    
    class func searchForGames(team: String, startDate: String, endDate: String, completion: @escaping ([Event]) -> ()) {
        
        let parameters: [String: Any] = [
            "team": team,
            "startDate": startDate,
            "endDate": endDate
        ]
        
        var events: [Event] = []
        
        Alamofire.request(Router.searchForGames(parameters: parameters)).responseArray { (response: DataResponse<[Event]>) in
            
            print(response.result.value)
            guard let eventsList = response.result.value else {
                print("ERROR")
                return
            }
            events = eventsList
            completion(events)
            
        }
            
    }
    
    class func createTrip(event: Event?, arrival: String?, depart: String?, preferences: Preferences) {
        
        guard let event = event else { return }
        guard let arrive = arrival else { return }
        guard let depart = depart else { return }
        guard let lat = event.latitude else { return }
        guard let long = event.longitude else { return }
        
        
        print(event.longitude)
        
        let parameters: [String: Any] = [
            "lat": Double(lat) ?? "",
            "long": Double(long) ?? "",
            "arrivalTime": arrive,
            "departureTime": depart,
            "preferences": [
                "dayActivities" : ["specialEvents"],
                "nightActivities" : ["cocktailLounges"],
                "food" : ["upscale"]
            ]
        ]
        
        
        // TODO: Change responseJSON to responseObject with Mappable functionality
        
        Alamofire.request(Router.createTrip(parameters: parameters)).responseJSON { response in
        
            print("TRIP\n\n")
            print(response.result.value)
            
//            guard let eventsList = response.result.value else {
//                print("ERROR")
//                return
//            }
//            events = eventsList
//            completion(events)
            
        }
        
        
    }

}
