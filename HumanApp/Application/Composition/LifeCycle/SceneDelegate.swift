//
//  SceneDelegate.swift
//  HumanApp
//
//  Created by Никита Коголенок on 13.01.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appFactory: AppFactory?
    var appDIContainer: AppDIContainer?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        appDIContainer = AppDIContainer()
        appFactory = AppFactory(appDIContrainer: appDIContainer)
        appCoordinator = AppCoordinator(navigation: UINavigationController(), window: window, factory: appFactory, auth: appDIContainer?.auth)
        appCoordinator?.start()
        
        
//        window?.windowScene = windowScene
//        
//        let tabBarController = UITabBarController()
//        
//        let mainViewController = MainViewController()
//        let settingsViewController = SettingsViewController()
//        
//        // Set Tab Images
//        mainViewController.tabBarItem.image = UIImage(systemName: "house")
//        settingsViewController.tabBarItem.image = UIImage(systemName: "gear")
//        
//        // Set Tab Title
//        mainViewController.tabBarItem.title = "Main"
//        settingsViewController.tabBarItem.title = "Settings"
//        
//        let navigationMainVC = UINavigationController(rootViewController: mainViewController)
//        let navigationSettingsVC = UINavigationController(rootViewController: settingsViewController)
//        
//        tabBarController.viewControllers = [navigationMainVC, navigationSettingsVC]
//    
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
    }
}

