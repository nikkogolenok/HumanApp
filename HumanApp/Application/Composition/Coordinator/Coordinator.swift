//
//  Coordinator.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get set }
    func start()
}
