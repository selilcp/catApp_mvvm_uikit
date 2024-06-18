//
//  Coordinator.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
