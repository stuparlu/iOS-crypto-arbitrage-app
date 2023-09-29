//
//  LoginManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation

class LoginManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    static let shared = LoginManager()    
}
