//
//  LoginCoordinator.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func didFinishedLogin()
}

final class LoginCoordinator: Coordinator {
    
    // MARK: - Variable
    var navigation: UINavigationController
    var factory: LoginFactory
    weak var delegate: LoginCoordinatorDelegate?
    
    // MARK: - Init
    init(navigation: UINavigationController, factory: LoginFactory, delegate: LoginCoordinatorDelegate) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let controller = factory.makeLoginViewController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

// MARK: - LoginViewControllerCoordinator
extension LoginCoordinator: LoginViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishedLogin()
    }
}
