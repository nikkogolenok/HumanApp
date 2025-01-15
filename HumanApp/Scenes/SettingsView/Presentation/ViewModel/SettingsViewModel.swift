//
//  SettingsViewModel.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import Foundation

final class SettingsViewModel {
    
    private var itemsSettingsViewModel: [ItemSettingsViewModel] = [
        ItemSettingsViewModel(icon: "person", title: "User information", isNavigable: false, navigation: .userInfo),
        ItemSettingsViewModel(icon: "door.right.hand.open", title: "LogOut", isNavigable: false, navigation: .logOut),
        ItemSettingsViewModel(icon: "apps.iphone", title: "Version App 1.0.0", isNavigable: true, navigation: .noNavigation)
    ]
    
    private var auth: LogOutAuth?
    var settingsCount: Int {
        itemsSettingsViewModel.count
    }
    
    init(auth: LogOutAuth?) {
        self.auth = auth
    }
    
    private func logOut() {
        auth?.logOut()
    }
    
    func getItemSettingViewModel(row: Int) -> ItemSettingsViewModel {
        itemsSettingsViewModel[row]
    }
    
    func cellSeleced(row: Int) -> SettingsViewNavigation {
        let navigation = itemsSettingsViewModel[row].navigation
        if navigation == .logOut {
            logOut()
        }
        return navigation
    }
}
