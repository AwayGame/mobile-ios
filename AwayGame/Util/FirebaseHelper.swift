//
//  FirebaseHelper.swift
//  AwayGame
//
//  Created by Michael Fioretti on 5/23/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

func initializeDatabaseSubscription() {
    guard let uid = User.currentUser.uid else { return }
    Firestore.firestore().collection("user").document(uid).addSnapshotListener { documentSnapshot, error in
        guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
        }
        let source = document.metadata.hasPendingWrites ? "Local" : "Server"
        print("\(source) data: \(document.data())")
        // Update the current user from the database
        
        
        //User.currentUser = Mapper<User>().map(JSONString: document.data())
        //print("NEW USER: ", User.currentUser.name)
    }
}
