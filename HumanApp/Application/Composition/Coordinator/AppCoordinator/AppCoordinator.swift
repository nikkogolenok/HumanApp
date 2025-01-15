//
//  AppCoordinator.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    var factory: AppFactory?
    var auth: SessionCheckerAuth?
    private var loginCoordinator: Coordinator?
    private var mainTabBarCoordinator: Coordinator?
    
    init(navigation: UINavigationController, window: UIWindow?, factory: AppFactory?, auth: Auth?) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        configWindow()
        startSomeCoordinator()
    }
    
    private func configWindow() {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
        guard let auth else { return }
        
        auth.isSessionActive ? startMainTabBarCoordinator() : startLoginCoordinator()
    }
    
    private func startLoginCoordinator() {
        loginCoordinator = factory?.makeLogInCoordinator(navigation: navigation, delegate: self)
        loginCoordinator?.start()
    }
    
    private func startMainTabBarCoordinator() {
        mainTabBarCoordinator = factory?.makeTabBarCoordinator(navigation: navigation, delegate: self)
        mainTabBarCoordinator?.start()
    }
}

// MARK: - LoginCoordinatorDelegate
extension AppCoordinator: LoginCoordinatorDelegate {
    func didFinishedLogin() {
        navigation.viewControllers = []
        loginCoordinator = nil
        startSomeCoordinator()
    }
}

extension AppCoordinator: MainTabBarCoordinatorDelegate {
    func didFinish() {
        navigation.viewControllers = []
        loginCoordinator = nil
        mainTabBarCoordinator = nil
        startSomeCoordinator()
    }
}
