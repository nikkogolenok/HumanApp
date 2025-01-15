//
//  LoginViewModel.swift
//  HumanApp
//
//  Created by Никита Коголенок on 14.01.25.
//

import Foundation

final class LoginViewModel {
    var logInAuth: LogInAuth?
    
    init(logInAuth: LogInAuth? ) {
        self.logInAuth = logInAuth
    }
    
    func logIn() {
        logInAuth?.logIn()
    }
}
