//
//  FirebaseSubscription.swift
//  AwayGame
//
//  Created by Michael Fioretti on 5/23/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

protocol FirebaseSubcription: class {
    func initializeDatabaseSubscription() 
    func handleUpdate(data: [String: Any])
}


