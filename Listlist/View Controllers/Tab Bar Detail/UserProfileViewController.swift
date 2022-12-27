//
//  UserProfileViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-10-12.
//

import UIKit
import Firebase
import FirebaseAuth

class UserProfileViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var friendsLabel: UILabel!
    
    @IBOutlet weak var critiquesLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    // Properties
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check
        DatabaseServices.checkFriendRequests(uid: user!.uid!) { (friendRequests) in
            
            // Check if user already sent a friend request
            if friendRequests.contains(Auth.auth().currentUser!.uid) {
                
                // Change button to already sent mode
                self.addFriendButton.setTitle("Sent", for: .normal)
                self.addFriendButton.backgroundColor = UIColor(red: 165, green: 165, blue: 164, alpha: 1)

            }
            else {
                print("It does not contain this user")
            }
            
        }
        
        // Styling
        Styling.styleCircularAvatarImage(imageView: avatarImageView)
        Styling.styleHeader(label: titleLabel, size: 70)
        addFriendButton.layer.cornerRadius = 8
        
        // Configure labels
        usernameLabel.text = user!.username
        
        friendsLabel.text = "Friends: \(String(describing: user!.friendsCount))"
        critiquesLabel.text = "Critiques: \(String(describing: user!.critiquesCount))"
        

        
    }
    
    // @IBActions
    @IBAction func backButtonTapped(_ sender: Any) {
        
        // Dismiss animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func addFriendButtonTapped(_ sender: Any) {
        
        // Send friend request to the profile the user is currently on
        DatabaseServices.sendFriendRequest(uid: user!.uid!)
        
        // After sending request, check if the friend request is currently there or if they are already friends, update label and button properly
        
        
    }
}
