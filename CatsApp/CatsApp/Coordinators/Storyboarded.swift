//
//  Storyboarded.swift
//  CatsApp
//
//  Created by Selil on 18/06/2024.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName: StoryboardName) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: StoryboardName) -> Self {
        // this pulls out full name of view controller
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving class name of view controller
        let className = fullName.components(separatedBy: ".")[1]

        // load storyboard with name
        let storyboard = UIStoryboard(name: storyboardName.rawValue,
                                      bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
