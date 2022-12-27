//
//  Utilities.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import Foundation
import Firebase

class Utilities {
    
    // Method for validating password using a regular expression
    static func isPasswordValid(_ password:String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordTest.evaluate(with: password)
    }
    
    // Method for validating email using a regular expression
    static func isEmailValid(_ email:String) -> Bool {
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        return emailTest.evaluate(with: email)
    }
    
    // Method for validating username
    static func isUsernameValid(_ username:String) -> Bool {
        
        // Length and lowercase
        if username.count > 16 || username.count < 3 || username.lowercased() != username {
            
            return false
            
        }
        
        // Detecting swear words
        let lowercaseName = username.lowercased()
            
        let inappropriateWords = ["fuck","shit","nigger","nigga","crap","cunt","pussy","cuck","dick","cock","penis","vagina","ass","butt", "coon"]
            
        for i in inappropriateWords {
            if lowercaseName.contains(i) {
                
                return false
            }
        }
 
        return true
    }
    
    static func isUsernameTaken(_ username:String, completion: @escaping (Int) -> Void) {
        
        // Detecting uniqueness of username
        print("Working first")
        DispatchQueue.main.async {
        
            // Database reference
            
            let database = Firestore.firestore()
            
            database.collection("users").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
                
                // Error check
                if error != nil {
                    
                    print("There was an error verifying username uniqueness")
                    
                }
                
                let documents = querySnapshot?.documents
                
                print("Document array length is \(documents!.count)")
                
                if documents!.count > 0 {
                    
                    // Username is taken
                    // Need to run ints on completion because we need a third option, so bool won't work (taken, not taken, undecided)
                    print("This username is taken")
                    completion(2)
                    
                }
                
                else {
                    
                    // Username is new
                    print("This username is not taken")
                    completion(3)

                }
                
                
            }
        }
    }
}
