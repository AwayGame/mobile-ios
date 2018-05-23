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
        
        handleUpdate(data: document.data())
    }
}

func handleUpdate(data: [String: Any]) {
    // Update the current user from the database
    //AwayGameAPI.verifyUser(with: User.currentUser)
    print("User has been updated")
    // TODO: Use the following code below to update the user...
    // guard let user = User(JSON: data) else { return }
    // User.currentUser = user
}
