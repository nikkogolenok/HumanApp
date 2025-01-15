//
//  SettingsCoordinator + SettingsCoordinatorViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import Foundation

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    
    func didSelecedCell(settingsViewNavigation: SettingsViewNavigation) {
        switch settingsViewNavigation {
        case .userInfo:
            break
        case .logOut:
            delegate?.didTapLogOut()
        case .noNavigation:
            break
        }
    }
}
