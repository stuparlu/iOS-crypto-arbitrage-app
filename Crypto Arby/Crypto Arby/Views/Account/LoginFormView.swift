//
//  LoginFormView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginFormView: View {
    @StateObject private var viewModel = LoginFormViewViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLogin: Bool = true
    
    var body: some View {
        Form {
            Picker("", selection: $isLogin) {
                Text(StringKeys.login).tag(true)
                Text(StringKeys.register).tag(false)
            }
            .pickerStyle(.segmented)
            TextField(StringKeys.email, text: $email)
                .onTapGesture {
                    email = ""
                }
            SecureField(StringKeys.password, text: $password)
                .onTapGesture {
                    password = ""
                }
            Button {
                viewModel.authenticate(email: email, password: password, isLogin: isLogin)
            } label: {
                Text(isLogin ? StringKeys.login : StringKeys.register)
            }
        }
        .alert("Invalid e-mail", isPresented: $viewModel.emailAlertIsShown) {
            Button(StringKeys.ok, role: .cancel) {}
        } message: {
            Text("E-mail address is invalid.")
        }
        .alert("Invalid Password", isPresented: $viewModel.passwordAlertIsShown) {
            Button(StringKeys.ok, role: .cancel) {}
        } message: {
            Text("You have to type a password that is at least 6 characters long, contains at least one uppercase, lowercase and numerical and special character with no whitespaces.")
        }

        
    }
}

#Preview {
    LoginFormView()
}
