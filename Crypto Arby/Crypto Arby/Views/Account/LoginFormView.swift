//
//  LoginFormView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginFormView: View {
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
                print(email)
                print(password)
            } label: {
                Text(isLogin ? StringKeys.login : StringKeys.register)
            }
            
        }
    }
}

#Preview {
    LoginFormView()
}
