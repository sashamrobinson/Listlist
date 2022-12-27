//
//  LocalStorageService.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import Foundation

class LocalStorageService {
    
    // Method for saving user to local storage
    static func saveUser(userId:String) {
        
        // Get a reference to UserDefaults
        let defaults = UserDefaults.standard
        
        // Save the userId to the defaults
        defaults.set(userId, forKey: Constants.userIdKey)
    }
    
    // Method for retrieving user defaults
    static func retrieveUser() -> String? {
        
        // Get a reference to UserDefaults
        let defaults = UserDefaults.standard
        
        // Get the user information
        // Needs to be casted as String so it knows what datatype to expect
        let userId = defaults.value(forKey: Constants.userIdKey) as? String
        
        print(userId)
        
        // Return the result as userId String
        if userId != nil {
            
            return userId!
            
        }
        else {
            
            return nil
            
        }
    }
    
    // This is related to the sign out functionality of our app
    static func clearUser() {
        
        // Get a reference to UserDefaults
        let defaults = UserDefaults.standard
        
        // Clear the values for the keys
        
        // This is done by setting the value for each key to nil
        defaults.setValue(nil, forKey: Constants.userIdKey)

    }
}
