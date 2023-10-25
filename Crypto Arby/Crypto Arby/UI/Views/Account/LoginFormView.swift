//
//  LoginFormView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginFormView: View {
    @StateObject private var viewModel = LoginFormViewViewModel()
    @StateObject private var loginManager = LoginManager.shared
    var body: some View {
        VStack {
            Spacer()
            Form {
                Picker("", selection: $viewModel.isLogin) {
                    Text(StringKeys.login).tag(true)
                    Text(StringKeys.register).tag(false)
                }
                .frame(height: 10)
                .padding()
                .pickerStyle(.segmented)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10.0)
                    .fill(ThemeManager.accentColor))
                TextField(StringKeys.email, text: $viewModel.email)
                    .frame(height: 30)
                    .textInputAutocapitalization(.never)
                    .onTapGesture {
                        viewModel.email = ""
                    }
                SecureField(StringKeys.password, text: $viewModel.password)
                    .frame(height: 30)
                    .textInputAutocapitalization(.never)
                    .onTapGesture {
                        viewModel.password = ""
                    }
            }
            .formStyle(ColumnsFormStyle())
            .scrollContentBackground(.hidden)
            .alert(StringKeys.invalidEmailTitle, isPresented: $viewModel.emailAlertIsShown) {
                Button(StringKeys.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.invalidEmailMessage)
            }
            .alert(StringKeys.invalidPasswordTitle, isPresented: $viewModel.passwordAlertIsShown) {
                Button(StringKeys.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.invalidPasswordMessage)
            }
            .alert(StringKeys.registrationFailedTitle, isPresented: $loginManager.registerErrorHappened) {
                Button(StringKeys.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.registrationFailedMessage)
            }
            .alert(StringKeys.loginFailedTitle, isPresented: $loginManager.loginErrorHappened) {
                Button(StringKeys.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.loginFailedMessage)
            }
            Button {
                viewModel.authenticate()
            } label: {
                Text(viewModel.isLogin ? StringKeys.login : StringKeys.register)
                    .frame(width: 150, height: 40)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    LoginFormView()
}
