//
//  LoginFormViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 30.9.23..
//

import Foundation

class LoginFormViewViewModel: ObservableObject {
    @Published var emailAlertIsShown = false
    @Published var passwordAlertIsShown = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogin: Bool = true
    
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
        if !isValidEmail(email: email) {
            emailAlertIsShown = true
            return
        }
        
        if !isValidPassword(password: password) {
            passwordAlertIsShown = true
            return
        }
        
        if isLogin {
            LoginManager.shared.login(email, password)
        } else {
            LoginManager.shared.register(email, password)
        }
    }
}
