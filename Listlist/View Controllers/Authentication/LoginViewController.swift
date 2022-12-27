//
//  LoginViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Styling
        Styling.styleHeader(label: titleLabel, size: 70)
        
        loginButton.layer.cornerRadius = 8
        createAccountButton.layer.cornerRadius = 8
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkForUser()
    }
    
    // @IBActions
    @IBAction func loginAccountTapped(_ sender: Any) {
        
        let signInAccountVC = self.storyboard!.instantiateViewController(identifier: Constants.signInAccountVC) as! SignInViewController
        
        signInAccountVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(signInAccountVC, animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        let createAccountVC = self.storyboard!.instantiateViewController(identifier: Constants.createAccountVC) as! CreateAccountViewController
        
        createAccountVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(createAccountVC, animated: true, completion: nil)
        
        
    }
    // Method for checking for user in user defaults
    func checkForUser() {
        
        print("Checking for user...")
        
        if LocalStorageService.retrieveUser() != nil {
            
            // Transition to home screen
            print("User has been found, transitioning to TabBarController")
            
            let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.tabBar)
            
            self.view.window?.rootViewController = tabBarVC
            self.view.window?.makeKeyAndVisible()
            
        }
        
        else {
            print("User not found")
            
        
        }
    }

}
