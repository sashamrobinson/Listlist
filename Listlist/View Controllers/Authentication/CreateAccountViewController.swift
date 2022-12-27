//
//  CreateAccountViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import UIKit
import FirebaseAuth
import Firebase
import AVKit

class CreateAccountViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // Properties
    var valid = Int()
    var validUsername = String()
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Styling.styleAuthField(textfield: nameTextField)
        
        Styling.styleAuthField(textfield: emailTextField)
        
        Styling.styleAuthField(textfield: usernameTextField)
        
        Styling.styleAuthField(textfield: passwordTextField)
        
        Styling.styleHeader(label: titleLabel, size: 70)
        
        confirmButton.layer.cornerRadius = 8
        
        errorLabel.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpVideo()

    }
    
    // Method for displaying video
    func setUpVideo() {
        
    }
    
    // Method for validating fields and making sure the user has proper information before creating them
    // Return nil -> No error, else returns error
    func validation() -> String? {
       
        // Check that all fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
            
        }
        
        // Make sure username is correct length, wording and casing
        let cleanedUsername = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Utilities.isUsernameValid(cleanedUsername) {
            
            // Username is not correct
            return "Usernames must be within 3-16 characters, all lowercase and contain no inappropriate words"
            
        }
        
        // Check that the password is secured
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        // Check that the email is correct
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isEmailValid(cleanedEmail) == false {
            
            return "Please make sure you enter a valid email address"
        }
 
        return nil
    }
    
    func usernameValidation() {
        
        // MARK: -- Username related checking
        // Create a dispatch group and queue so that the code waits for codebase to call before continuing
        let cleanedUsername = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check for unique username
        
        Utilities.isUsernameTaken(cleanedUsername) { (validInt) in
            
            let group = DispatchGroup()
            group.enter()
            
            DispatchQueue.main.async {
                
                // Assign closure bool
                print(self.valid)
                print(validInt)
                self.valid = validInt
                print(self.valid)
                print("Got here")
                group.leave()
                
            }
            
            group.notify(queue: .main) {
                
                // Checks valid variable
                print("String currently is \(self.validUsername)")
                self.validUsername = ""
                print("Valid is \(self.valid), now going into if statement")
                if self.valid == 2 {
                
                    self.validUsername = "Username is taken"
                    
                }
                
                self.valid = 1

            }
        }
        
        
    }
    
    // @IBActions
    @IBAction func confirmTapped(_ sender: Any) {

        // Validate the fields
        let error = validation()
        
        if error != nil {
            
            // Theres an error, show it
            showError(message: error!)
            
        }

        else {
            
            // Clear error
            self.errorLabel.text = ""
            
            // Clean data
            let name = self.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let username = self.usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user in our database
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                // Check for errors
                if error != nil {
                    
                    // There was an error creating the user information
                    self.showError(message: "Error creating user, email possibly already in use")
                }
                else {
                    
                    // Display animation
                    // self.setUpVideo()
                    
                    // Get current date
                    let date = Date()
                    let formatter = DateFormatter()
                    
                    formatter.dateFormat = "MM/dd/yyyy"
                    
                    let dateResult = formatter.string(from: date)
                    
                    // User was created successfully, now store relevant data for the user to database
                    let database = Firestore.firestore()
                    
                    // MARK: -- Add profileURL and profilePhotoId to data set, starting with default url and id
                    
                    database.collection("users").document(result!.user.uid).setData(["name":name, "username":username, "uid":result!.user.uid, "dateCreated":dateResult, "friends":[], "critiques":[], "friendsCount":0, "critiquesCount":0, "friendRequests":[], ]) { (error) in
                        
                        if error != nil {
                            
                            // There was an error
                            self.showError(message: "User data could not be saved correctly")
                        }
                    }
                    
                    // Add user to user defaults
                    LocalStorageService.saveUser(userId: result!.user.uid)
                    print("Saved user to UserDefaults")
                    
                    
                    // Transition to home screen
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.tabBar)

                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
            }
        }
        
    }
    
    func showError(message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
