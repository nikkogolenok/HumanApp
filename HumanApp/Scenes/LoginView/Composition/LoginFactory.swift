//
//  LoginFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

struct LoginFactory {
    let appDIContainer: AppDIContainer?
    
    func makeLoginViewController(coordinator: LoginViewControllerCoordinator) -> UIViewController {
        LoginViewController(coordinator: coordinator, viewModel: LoginViewModel(logInAuth: appDIContainer?.auth))
    }
}
