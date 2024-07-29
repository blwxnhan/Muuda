//
//  MusicListCoordinator.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

final class MusicListCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var presentedViewController: UIViewController? = nil
    
    var navigationController: UINavigationController

    func start() {

    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .black
    }
}

extension MusicListCoordinator {
    
}
