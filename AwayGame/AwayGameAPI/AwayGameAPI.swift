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
    
    class func createTrip(request: TripRequest?, completion: @escaping (Trip) -> ()) {
        
        let parameters: [String: Any] = [
            "lat": request?.lat ?? "",
            "long": request?.long ?? "",
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
        
        let tempParameters: [String: Any] = [
            "lat": 38.0406,
            "long": -84.5037,
            "userId": User.currentUser.uid ?? "",
            "preferences": [
                "dayActivities": ["shopping", "historicalPlaces"],
                "nightActivities": ["cocktailLounges", "breweries", "sportsbars"],
                "food": ["barFood", "coffeeShops", "upscale", "fastFood"]
            ],
            "arrivalTime": "2018-09-21T19:00:00.000Z",
            "departureTime": "2018-09-23T16:00:00.000Z",
            "gameId": "Z7r9jZ1AeaMft"
        ]
        
        print(parameters)
        
        Alamofire.request(Router.createTrip(parameters: tempParameters)).responseObject { (response: DataResponse<Trip>) in
            print("\n\n--------------------------")
            print("TRIP\n\n")
            print(response)
            
            guard let tempTrip = response.result.value else {
                print("ERROR")
                return
            }
            completion(tempTrip)
        }
        
        
    }

}
