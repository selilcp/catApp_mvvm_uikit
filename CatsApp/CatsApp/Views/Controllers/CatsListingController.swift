//
//  CatsListingController.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

class CatsListingController: UIViewController, Storyboarded {
    
    var coordinator: MainCoordinator?
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CatsApp"
    }


}

