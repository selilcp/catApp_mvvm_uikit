//
//  MainCoordinator.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CatsListingController.instantiate(storyboardName: .Main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}
