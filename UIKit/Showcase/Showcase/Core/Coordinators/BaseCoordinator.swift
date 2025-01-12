//
//  BaseCoordinator.swift
//  Showcase
//
//  Created by Eco Dev S-SSD  on 12/01/2025.
//

import UIKit

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private var container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer = .shared) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        fatalError("Start method must be implemented by child coordinator")
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
