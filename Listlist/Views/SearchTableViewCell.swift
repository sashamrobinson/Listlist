//
//  SearchTableViewCell.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // @IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var personalNameLabel: UILabel!
    
    @IBOutlet weak var backcolorView: UIView!
    
    // Properties
    var user:User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Styling
        backcolorView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Method for displaying details
    func displayUser(user:User) {
        
        // Clear image to avoid accidental duplicates
        self.profileImage.image = nil
        
        self.user = user
        
        // Set the username
        usernameLabel.text = user.username
        
        // Set the personal name
        personalNameLabel.text = user.name
        
        
        
        
    }
    

}
