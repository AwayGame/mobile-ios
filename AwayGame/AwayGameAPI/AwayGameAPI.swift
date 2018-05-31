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
    
    class func createTrip(request: TripRequest?, completion: @escaping (String?) -> ()) {
        
        let parameters: [String: Any] = [
            "lat": request?.lat,
            "long": request?.long,
            "arrivalTime": request?.arrivalTime ?? "",
            "departureTime": request?.departureTime ?? "",
            "gameId": request?.eventId ?? "",
            "userId": User.currentUser.uid ?? "",
            "preferences": [
                "dayActivities" : request?.preferences?.interests ?? [],
                "nightActivities" : request?.preferences?.nightlife ?? [],
                "food" : request?.preferences?.food ?? []
            ]
        ]
        
        // TODO: Change responseJSON to responseObject with Mappable functionality
        
        Alamofire.request(Router.createTrip(parameters: parameters)).responseJSON { response in
            print("\n\n--------------------------")
            print("TRIP\n\n")
            print(response.result.value)
            completion(response.description)
//            guard let eventsList = response.result.value else {
//                print("ERROR")
//                return
//            }
//            events = eventsList
//            completion(events)
            
        }
        
        
    }

}
