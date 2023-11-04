//
//  LoginFormViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 30.9.23..
//

import Foundation

class LoginFormViewModel: ObservableObject {
    @Published var model = LoginFormModel()
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        if password.contains(" ") {
            return false
        }
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{6,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func authenticate() {
        if !isValidEmail(email: model.email) {
            model.emailAlertIsShown = true
            return
        }
        
        if !isValidPassword(password: model.password) {
            model.passwordAlertIsShown = true
            return
        }
        
        if model.isLogin {
            LoginManager.shared.login(model.email, model.password)
        } else {
            LoginManager.shared.register(model.email, model.password)
        }
    }
}
