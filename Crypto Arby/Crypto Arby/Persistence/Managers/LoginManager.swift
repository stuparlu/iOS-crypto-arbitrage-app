//
//  LoginManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation
import FirebaseAuth

class LoginManager: ObservableObject {
    @Published var registerErrorHappened: Bool = false
    @Published var loginErrorHappened: Bool = false
    @Published var isLoggedIn: Bool
    var currentUser: User?
    
    
    init() {
        currentUser = Auth.auth().currentUser
        isLoggedIn = currentUser != nil
    }
    
    static let shared = LoginManager()
    
    func register(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password)  { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
                strongSelf.registerErrorHappened.toggle()
            } else {
                strongSelf.setUserData(data: authResult?.user)
            }
        }
    }
    
    func login(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
                strongSelf.loginErrorHappened.toggle()
            } else {
                strongSelf.setUserData(data: authResult?.user)
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            setUserData(data: nil)
        } catch {
            fatalError("Failed to sign out: \(error.localizedDescription)")
        }
    }
    
    func setUserData(data: User?) {
        currentUser = data
        isLoggedIn = data != nil
    }
}
