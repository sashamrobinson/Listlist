//
//  SettingsViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // Properties
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grab user based off signed in Auth
        DatabaseServices.retrieveUser { (retrievedUser) in

            // Assign user
            self.user = retrievedUser
            
            // Assign properties on main thread
            
            // [self] means that self is implicitly given to all values in this completion
            DispatchQueue.main.async { [self] in
                
                // Assign labels
                dateLabel.text = "Account Created: \(String(describing: user!.dateCreated!))"
                
                usernameLabel.text = user!.username!
                
                emailLabel.text = Auth.auth().currentUser!.email
                
                nameLabel.text = user!.name!
            }
        }
        
        // Styling
        Styling.styleHeader(label: titleLabel, size: 70)
        
        Styling.styleCircularAvatar(buttonView: profileImageView)
        
        logOut.layer.cornerRadius = 8
        
        editButton.layer.cornerRadius = 8
        
    }
    
    // @IBActions
    @IBAction func profileTapped(_ sender: Any) {
    }
    
    @IBAction func editTapped(_ sender: Any) {
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        // Create confirmation alert
        let alert = UIAlertController(title: "Are you sure you want to sign out?", message: "You will need to log back in through email and password.", preferredStyle: .alert)
        
        // Add actions
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (yesAction) in
            
            do {
                    
                // Successfully signning out user
                // Sign out with Firebase Auth (.signOut() catches)
                try Auth.auth().signOut()
                    
                // Clear local storage
                LocalStorageService.clearUser()
                
                }
                catch {
                    
                    // There was an error signing out
                    print("Error signing out")
                }
                
                // Transition to authentication flow
            let loginVC = self.storyboard?.instantiateViewController(identifier: Constants.loginVC)
                
                self.view.window?.rootViewController = loginVC
                self.view.window?.makeKeyAndVisible()
        
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (noAction) in
            
            // Dismiss pop up
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true)
        
    }

    
}

