//
//  ItemTabBarFactory.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol ItemTabBarFactory { }

extension ItemTabBarFactory {
    
    func makeItemTabBar(navigation: UINavigationController, title: String, image: String, selectedImage: String) {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), selectedImage: UIImage(systemName: selectedImage))
        navigation.tabBarItem = tabBarItem
    }
}
