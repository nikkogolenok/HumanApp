//
//  MainTabBarFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

struct MainTabBarFactory {
    let appDConstrainer: AppDIContainer?
    
    func makeTabBarController() -> UITabBarController {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.viewControllers = []
        return mainTabBarController
    }
    
    func makeChildCoordinators(delegate: SettingsCoordinatorDelegate) -> [Coordinator] {
        let mainCoordinator = makeMainCoordinator()
        let settingsCoordinator = makeSettingsCoordinator(delegate: delegate)
        return [mainCoordinator, settingsCoordinator]
    }
    
    private func makeMainCoordinator() -> Coordinator {
        let factory = MainFactoryImp()
        let navigation = UINavigationController()
        return MainCoordinator(navigation: navigation, factory: factory)
    }

    private func makeSettingsCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = SettingsFactory(appDIContainer: appDConstrainer)
        let navigation = UINavigationController()
        return SettingsCoordinator(navigation: navigation, factory: factory, delegate: delegate)
    }
}
