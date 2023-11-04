//
//  LoginFormView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginFormView: View {
    @StateObject private var viewModel = LoginFormViewModel()
    @StateObject private var loginManager = LoginManager.shared
    var body: some View {
        VStack {
            Spacer()
            Form {
                Picker("", selection: $viewModel.model.isLogin) {
                    Text(StringKeys.displayed.login).tag(true)
                    Text(StringKeys.displayed.register).tag(false)
                }
                .frame(height: 10)
                .padding()
                .pickerStyle(.segmented)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10.0)
                    .fill(ThemeManager.accentColor))
                TextField(StringKeys.displayed.email, text: $viewModel.model.email)
                    .frame(height: 30)
                    .textInputAutocapitalization(.never)
                    .onTapGesture {
                        viewModel.model.email = ""
                    }
                SecureField(StringKeys.displayed.password, text: $viewModel.model.password)
                    .frame(height: 30)
                    .textInputAutocapitalization(.never)
                    .onTapGesture {
                        viewModel.model.password = ""
                    }
            }
            .formStyle(ColumnsFormStyle())
            .scrollContentBackground(.hidden)
            .alert(StringKeys.alerts.invalidEmailTitle, isPresented: $viewModel.model.emailAlertIsShown) {
                Button(StringKeys.displayed.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.alerts.invalidEmailMessage)
            }
            .alert(StringKeys.alerts.invalidPasswordTitle, isPresented: $viewModel.model.passwordAlertIsShown) {
                Button(StringKeys.displayed.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.alerts.invalidPasswordMessage)
            }
            .alert(StringKeys.alerts.registrationFailedTitle, isPresented: $loginManager.registerErrorHappened) {
                Button(StringKeys.displayed.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.alerts.registrationFailedMessage)
            }
            .alert(StringKeys.alerts.loginFailedTitle, isPresented: $loginManager.loginErrorHappened) {
                Button(StringKeys.displayed.ok, role: .cancel) {}
            } message: {
                Text(StringKeys.alerts.loginFailedMessage)
            }
            Button {
                viewModel.authenticate()
            } label: {
                Text(viewModel.model.isLogin ? StringKeys.displayed.login : StringKeys.displayed.register)
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
