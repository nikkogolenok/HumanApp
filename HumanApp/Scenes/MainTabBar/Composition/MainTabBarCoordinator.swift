//
//  MainTabBarCoordinator.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol MainTabBarCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class MainTabBarCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: MainTabBarFactory
    private weak var delegate: MainTabBarCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    
    init(navigation: UINavigationController, factory: MainTabBarFactory, delegate: MainTabBarCoordinatorDelegate) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let navigationTabBar = factory.makeTabBarController()
        navigation.pushViewController(navigationTabBar, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCoordinators(delegate: self)
        let childNavigation = childCoordinators.map { $0.navigation }
        childCoordinators.forEach { $0.start() }
        navigationTabBar.viewControllers = childNavigation
    }
}

extension MainTabBarCoordinator: SettingsCoordinatorDelegate {
    func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
}

