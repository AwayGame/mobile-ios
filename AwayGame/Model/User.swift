//
//  User.swift
//  AwayGame
//
//  Created by Blake Swaidner on 5/14/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation

final class User {
    
    static let currentUser = User()
    private init () {}
    
    public var name: String?
    public var email: String?
    public var photoUrl: String?
    public var uid: String?
    
}
