//
//  ActivityViewController.swift
//  Listlist
//
//  Created by Sasha Robinson on 2020-09-30.
//

import UIKit

class ActivityViewController: UIViewController {
    
    // @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Styling
        Styling.styleHeader(label: titleLabel, size: 70)
        
    }

}
