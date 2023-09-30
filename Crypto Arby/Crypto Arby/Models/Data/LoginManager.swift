//
//  LoginManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation
import FirebaseAuth

class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    static let shared = LoginManager()
    
    func register(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password)  { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // ...
            if let error = error {
                //handle error
            }
          }
    }
    
    func login(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // ...
            if let error = error {
                //handle error
            }
          }

    }
}
