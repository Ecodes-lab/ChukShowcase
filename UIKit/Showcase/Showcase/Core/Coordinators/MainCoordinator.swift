//
//  MainCoordinator.swift
//  Showcase
//
//  Created by Eco Dev S-SSD  on 12/01/2025.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    private var showcaseController: ShowcaseController?
    
    override func start() {
        let showcaseController = ShowcaseController()
        self.showcaseController = showcaseController
        
        navigationController.setViewControllers([showcaseController], animated: true)
    }
}
