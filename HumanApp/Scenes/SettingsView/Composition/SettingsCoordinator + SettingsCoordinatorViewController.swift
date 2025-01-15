//
//  SettingsCoordinator + SettingsCoordinatorViewController.swift
//  HumanApp
//
//  Created by Никита Коголенок on 15.01.25.
//

import UIKit

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    
    func didSelecedCell(settingsViewNavigation: SettingsViewNavigation) {
        switch settingsViewNavigation {
        case .userInfo:
            navigation.present(callUserInformation(), animated: true)
        case .logOut:
            delegate?.didTapLogOut()
        case .noNavigation:
            break
        }
    }
    
    private func callUserInformation() -> UIAlertController {
        let alertController = UIAlertController(title: "This App was created by Kogolenok Nikita", message: "Tel: @kogolenoknikita", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        return alertController
    }
}
