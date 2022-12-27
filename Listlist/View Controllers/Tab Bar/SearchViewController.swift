//
//  SearchViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import UIKit

class SearchViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var friendsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tabBarController!.delegate = self
        
        // Styling
        Styling.styleHeader(label: titleLabel, size: 70)
        
        // Search bar
        searchBar.searchTextField.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        searchBar.searchTextField.textColor = .darkGray
        searchBar.barTintColor = UIColor.lightGray
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.autocapitalizationType = .none
        
    }
    
}

// MARK: -- Table View Extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count < 20 ? users.count : 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.searchTableCell, for: indexPath) as! SearchTableViewCell
        
        // Customize the cell
        cell.layer.cornerRadius = 8
        
        let user = self.users[indexPath.row]
        
        cell.displayUser(user: user)
        
        // Return the cell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Check we have recieved user and that there is a index path associated with the selected row
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        // Present detail view controller
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.userProfileVC) as! UserProfileViewController
        
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        vc.user = self.users[tableView.indexPathForSelectedRow!.row]
        
        // Present animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)

    }
    
    
}


// MARK: -- Search Bar Extension
extension SearchViewController: UISearchBarDelegate, UISearchDisplayDelegate {
        
    // Called every time search bar updates
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String) {
        
        // Grab users and use closure to update table view
        DatabaseServices.retrieveSearchedUsers(searchField: searchText) { (retrievedUsers) in
        
            // Make label disappear
            self.friendsLabel.alpha = 0
            
            if retrievedUsers.count == 0 {
                self.users.removeAll()
                self.tableView.reloadData()
                
            }
            else {
                
                // Reassign foodbanks
                self.users = retrievedUsers
                
                // Reload table view
                self.tableView.reloadData()
            }
            
            
        }
    }
}

// MARK: -- Tab Bar Extension
extension SearchViewController: UITabBarControllerDelegate {
    
    // Method for selecting tab bar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let index = tabBarController.selectedIndex
        
        // If the index is 1, it is the second tab so we don't want to check anything
        if index != 1 {
            
            // Make the label visible again
            self.friendsLabel.alpha = 0.5
            
            // Clear table view
            self.users.removeAll()
            self.tableView.reloadData()
            
        }
    }
    
}
