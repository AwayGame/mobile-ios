//
//  UserPreferences.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/22/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation

enum PreferenceType {
    case Food
    case Interest
    case Nightlife
    
    var description: String {
        switch self {
        case .Food:
            return "Food"
        case .Interest:
            return "Interest"
        case .Nightlife:
            return "Nightlife"
        }
    }
}

class UserPreferences {
    
    public var group: String? = ""
    public var food: [String]? = []
    public var interests: [String]? = []
    public var nightlife: [String]? = []

}
