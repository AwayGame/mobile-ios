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
    
    class func verifyUser(with user: User, completion: @escaping (User) -> ()) {
        
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
            completion(user)
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
        
        
        print(parameters)
        
        Alamofire.request(Router.createTrip(parameters: parameters)).responseObject { (response: DataResponse<Trip>) in
            print("\n\n--------------------------")
            print("TRIP\n\n")
            print(response)
            
            print(response.result)
            print(response.result.value)
            
            guard let tempTrip = response.result.value else {
                print("ERROR")
                return
            }
            completion(tempTrip)
        }
        
        
    }
    
    class func saveTrip(_ trip: Trip, user: User, completion: @escaping () -> ()) {
        
        guard let JSONString = trip.toJSONString(prettyPrint: false) else { return }
        
        print("\n\n\(JSONString) \n\n")
        
        let parameters: [String: Any] = [
            "userId": user.uid ?? "",
            "trip": JSONString
        ]
        
        Alamofire.request(Router.saveTrip(parameters: parameters)).responseObject { (response: DataResponse<Trip>) in
            print("\n\n--------------------------")
            print("SAVED\n\n")
            print(response)
            
            print(response.result)
            print(response.result.value)

            completion()
        }
        
    }
    
    class func deleteTrip(_ tripStub: TripStub, user: User, completion: @escaping () -> ()) {
        
        let parameters: [String: Any] = [
            "userId": user.uid ?? "",
            "tripId": tripStub.id ?? ""
        ]
        
        Alamofire.request(Router.deleteTrip(parameters: parameters)).responseObject { (response: DataResponse<Trip>) in
            print("\n\n--------------------------")
            print("DELETED\n\n")
            print(response)
            
            print(response.result)
            print(response.result.value)
            
            completion()
        }
        
    }
    
    class func getTrip(withId id: String?, completion: @escaping (Trip) -> ()) {
        Alamofire.request(Router.getTrip(withId: id ?? "")).responseObject { (response: DataResponse<Trip>) in
            print("\n\n--------------------------")
            print("TRIP\n\n")
            print(response)
            
            print(response.result)
            print(response.result.value)
            
            guard let tempTrip = response.result.value else {
                print("ERROR")
                return
            }
            completion(tempTrip)
        }
    }

}
