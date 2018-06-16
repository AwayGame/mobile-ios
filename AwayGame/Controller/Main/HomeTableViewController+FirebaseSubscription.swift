//
//  HomeTableViewController+FirebaseSubscription.swift
//  AwayGame
//
//  Created by Blake Swaidner on 6/16/18.
//  Copyright © 2018 AwayGame. All rights reserved.
//

import Firebase
import UIKit

extension HomeTableViewController: FirebaseSubcription {
    
    func initializeDatabaseSubscription() {
        
        print(User.currentUser)
        
        guard let uid = User.currentUser.uid else {
            print("returning")
            return
        }
        Firestore.firestore().collection("user").document(uid).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            print("HERREEE")
            self.handleUpdate(data: document.data())
        }
    }
    
    func handleUpdate(data: [String: Any]) {
        print("HANDLING UPDATE")
        guard let user = User(JSON: data) else {
            print("ERROR: USER NOT UPDATED")
            return
        }
        User.currentUser = user
        print("*Current User Updated*")
        updateTripStubs(forUser: user)
    }
    

    
}
