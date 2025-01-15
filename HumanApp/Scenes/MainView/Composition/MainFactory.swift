//
//  MainFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import UIKit

protocol MainFactory {
    func makeMainViewController() -> UIViewController
    func makeItemTabBar(navigation: UINavigationController)
}

struct MainFactoryImp: MainFactory {
    func makeMainViewController() -> UIViewController {
        let controller = MainViewController()
        controller.navigationItem.title = "Main"
        return controller
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(navigation: navigation, title: "Main", image: "house", selectedImage: "house.fill")
    }
}

extension MainFactoryImp: ItemTabBarFactory {
    
}

