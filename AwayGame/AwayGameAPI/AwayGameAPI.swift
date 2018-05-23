//
//  AwayGameAPI.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Alamofire

class AwayGameAPI {
    
    func verifyUser(with user: User) {

        let parameters: [String: Any] = [
            "name": user.name ?? "",
            "photoUrl": user.photoUrl ?? "",
            "email": user.email ?? "",
            "uid": user.uid ?? ""
        ]
        
        Alamofire.request(Router.verifyUser(parameters: parameters))
    }
    
    
    
    
}
