//
//  MainCoordinator.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: MainFactory
    
    init(navigation: UINavigationController, factory: MainFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let controller = factory.makeMainViewController()
        factory.makeItemTabBar(navigation: navigation)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(controller, animated: true)
    }
}


