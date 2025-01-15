//
//  AppFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

struct AppFactory {
    let appDIContrainer: AppDIContainer?
    
    func makeLogInCoordinator(navigation: UINavigationController, delegate: LoginCoordinatorDelegate) -> Coordinator {
        let loginFactory = LoginFactory(appDIContainer: appDIContrainer)
        return LoginCoordinator(navigation: navigation,
                                factory: loginFactory,
                                delegate: delegate)
    }
    
    func makeTabBarCoordinator(navigation: UINavigationController, delegate: MainTabBarCoordinatorDelegate) -> Coordinator {
        let factory = MainTabBarFactory(appDConstrainer: appDIContrainer)
        return MainTabBarCoordinator(navigation: navigation, factory: factory, delegate: delegate)
    }
}
