//
//  Coordinator.swift
//  Showcase
//
//  Created by Eco Dev S-SSD  on 12/01/2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
