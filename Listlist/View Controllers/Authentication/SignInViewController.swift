//
//  SignInViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        Styling.styleAuthField(textfield: emailTextField)
        
        Styling.styleAuthField(textfield: passwordTextField)
        
        Styling.styleHeader(label: titleLabel, size: 70)
        
        confirmButton.layer.cornerRadius = 8
        
        errorLabel.alpha = 0
        
    }
    
    // @IBActions
    @IBAction func confirmTapped(_ sender: Any) {
        
        // Validate text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                
                // Couldn't sign in
                self.errorLabel.text = "Couldn't sign in with this email and password"
                self.errorLabel.alpha = 1
            }
            
            else {
                
                // Get user properties of authentication
                let userId = Auth.auth().currentUser?.uid
                
                
                guard userId != nil else {
                    
                    print("User ID is nil")
                    return
                }
                
                // Add user to user defaults
                LocalStorageService.saveUser(userId: userId!)
                print("Saved user to UserDefaults")

                // Transition to home screen
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.tabBar)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
        
}
