//
//  User.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import Foundation
import Firebase

struct User {
    
    // Properties of a user
    var username:String?
    var name:String?
    var uid:String?
    var dateCreated:String?
    var profileURL:String?
    var profilePhotoId:String?
    var friends:[User]?
    var critiques:[Critique]?
    var friendsCount:Int?
    var critiquesCount:Int?
    
    init? (snapshot:QueryDocumentSnapshot) {
        
        // Parse the data out
        // .data() returns a dictionary with all the key : value pairs inside of the document
        let data = snapshot.data()
        
        let username = data["username"] as? String
        let name = data["name"] as? String
        let uid = data["uid"] as? String
        let dateCreated = data["dateCreated"] as? String
        let profileURL = data["profileURL"] as? String
        let profilePhotoId = data["profilePhotoId"] as? String
        let friendsCount = data["friendsCount"] as? Int
        let critiquesCount = data["critiquesCount"] as? Int
        
        // Friends and critique counts can be calculated with .count on the array, since we need to fetch both of these any time we are checking a profiles friend / critique count
        let friends = data["friends"] as? Array<User>
        let critiques = data["critiques"] as? Array<Critique>

        // Check for missing data, will check nil for photo url and id's because we will give them a default photo on creation, don't check nil for friends and critiques because by default they are nil
        if username == nil || uid == nil || dateCreated == nil {
            
            // MARK: -- Include Photo url and id's in nil check once photo storage and database is properly created.
            
            print("Some data was missing from a Foodbank object")
            return nil
        }
        
        // Set our properties
        self.username = username
        self.name = name
        self.uid = uid
        self.dateCreated = dateCreated
        self.profileURL = profileURL
        self.profilePhotoId = profilePhotoId
        self.friends = friends
        self.critiques = critiques
        self.friendsCount = friendsCount
        self.critiquesCount = critiquesCount
    }
    
}
