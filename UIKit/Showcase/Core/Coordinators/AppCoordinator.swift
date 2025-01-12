//
//  AppCoordinator.swift
//  Showcase
//
//  Created by Eco Dev S-SSD  on 12/01/2025.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showMainFlow()
    }
    
    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
}
