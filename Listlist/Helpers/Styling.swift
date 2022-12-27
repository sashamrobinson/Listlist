//
//  Styling.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-21.
//

import Foundation
import UIKit

class Styling {
    
    static func styleHeader(label:UILabel, size:CGFloat) {
        
        label.font = UIFont(name: "LeckerliOne-Regular", size: size)
    }
    
    static func styleAuthField(textfield:UITextField) {
        
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        
        textfield.leftViewMode = .always
        
        textfield.layer.cornerRadius = 8
        
    }
    
    // Button version of circular avatar
    static func styleCircularAvatar(buttonView:UIButton) {
        
        buttonView.layer.cornerRadius = (buttonView.frame.size.width) / 2
        buttonView.clipsToBounds = true
    }
    
    // Image view version of circular avatar
    static func styleCircularAvatarImage(imageView:UIImageView) {
        
        imageView.layer.cornerRadius = (imageView.frame.size.width) / 2
        imageView.clipsToBounds = true
    }
}
