//
//  DatabaseService.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-23.
//

import Foundation
import Firebase
import FirebaseAuth


class DatabaseServices {
    
    // Method for retrieving friends
    static func retrieveFriends() {
        
    }
    
    // Method for sending friend request
    static func sendFriendRequest(uid:String) {
        
        // Database
        let database = Firestore.firestore()
        
        // Add user to friend requests
        database.collection("users").document(uid).updateData(["friendRequests": FieldValue.arrayUnion([Auth.auth().currentUser!.uid])])
    }
    
    // Method for verifying / checking user in another users friend requests
    static func checkFriendRequests(uid:String, completion: @escaping ([String]) -> Void) {
        
        // Database
        let database = Firestore.firestore()
        
        // Grab users friendRequests
        database.collection("users").document(uid).getDocument { (documentSnapshot, error) in
            
            // Error checking
            guard error == nil else {
                print("Error getting users friend requests")
                return
            }
            
            // Make sure we got a document back
            if let documentSnapshot = documentSnapshot {
                
                let friendRequests = documentSnapshot.get("friendRequests")
                
                // Check friend requests for user id
                completion(friendRequests as! [String])
                
                
            }
        }
    }
    
    // Method for retrieving the logged in user of their Auth id.
    static func retrieveUser(user:String = Auth.auth().currentUser!.uid, completion: @escaping (User) -> Void) {

        // Fetch user
        let database = Firestore.firestore()
        
        // Get document off of current user
        database.collection("users").whereField("uid", isEqualTo: user).getDocuments { (querySnapshot, error) in
            
            // Error checking
            if error != nil {
               
                print("Error occured while grabbing users")
                return
            }
            
            // Verify documents
            let documents = querySnapshot?.documents
            
            if let documents = documents {
                
                // Can only be one document, else there is an error
                if documents.count == 1 {
                    
                    let user = User(snapshot: documents[0])
                    
                    // Nil check
                    if user != nil {
                        
                        completion(user!)
                    }
                }
                
                else {
                    
                    // MARK: - Log out user because there has to be a document with this uid and there can't be multiple
                    print("Document either doesn't exist or there are multiple documents with same uid, meaning there was an error")
                }
                
            }

            
        }

    }
    
    // Method for retrieving all users by search query
    static func retrieveSearchedUsers(searchField:String, completion: @escaping ([User]) -> Void) {
        
        // Database reference
        let database = Firestore.firestore()
        
        // Query based username
        database.collection("users").whereField("username", isEqualTo: searchField).getDocuments { (querySnapshot, error) in
            
            // Check for errors
            if error != nil {
                
                print("Error occured while grabbing users")
                return
            }
            
            // Get all the documents
            let documents = querySnapshot?.documents
            
            if let documents = documents {
                
                // If documents are empty for that query, query all users (to a max of 20)
                if documents == Optional([]) {
                    
                    database.collection("users").getDocuments { (querySnapshot, error) in
                        
                        // Check for errors
                        if error != nil {
                            
                            print("Error occured while grabbing users")
                            return
                        }
                        
                        // Get all the documents
                        let documents = querySnapshot?.documents
                        
                        if let documents = documents {
                            
                            var userArray = [User]()
                            
                            // Loop through documents returned
                            for i in documents {
                                
                                // Create instance of Foodbank with initializer code from document
                                let user = User(snapshot: i)
                                
                                // If the new Foodbank object isn't nil, add it to array
                                if user != nil {
                                    
                                    // Store it in our array
                                    userArray.insert(user!, at: 0)
                                }
                                
                                // Pass back in the array
                                completion(userArray)
                            }
                        }
                        
                    }
                }
                // Create an array to store our Foodbank instances
                var userArray = [User]()
                
                // Loop through documents returned
                for i in documents {
                    
                    // Create instance of Foodbank with initializer code from document
                    let user = User(snapshot: i)
                    
                    // If the new Foodbank object isn't nil, add it to array
                    if user != nil {
                        
                        // Store it in our array
                        userArray.insert(user!, at: 0)
                    }
                    
                    // Pass back in the array
                    completion(userArray)
                }
            
            }
                
        
        }
        
        
    }
     
}
