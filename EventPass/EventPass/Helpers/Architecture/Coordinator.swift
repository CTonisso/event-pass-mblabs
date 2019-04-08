//
//  Coordinator.swift
//  EventPass
//
//  Created by Carlos Marcelo Tonisso Junior on 3/29/19.
//  Copyright © 2019 Carlos Marcelo Tonisso Junior. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    
    /// The array containing any child Coordinators
    var childCoordinators: [Coordinator] { get set }
    
}

extension Coordinator {
    
    /// Add a child coordinator to the parent
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }
    
    /// Remove a child coordinator from the parent
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
