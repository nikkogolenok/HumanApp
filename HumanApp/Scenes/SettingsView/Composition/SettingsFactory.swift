//
//  SettingsFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import UIKit

struct SettingsFactory: ItemTabBarFactory {
    let appDIContainer: AppDIContainer?
    
    func makeSettingsController(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(auth: appDIContainer?.auth)
        let controller = SettingsViewController(viewModel: viewModel, coordinator: coordinator)
        controller.title = "Setting"
        return controller
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(navigation: navigation, title: "Settings", image: "gearshape.2", selectedImage: "gearshape.2.fill")
    }
}
