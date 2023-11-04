//
//  LoginButton.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginButton: View {
    @StateObject private var loginManager = LoginManager.shared
    @State private var showingSheet = false
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            HStack {
                Image(systemName: Symbols.user_account_icon)
                Text(StringKeys.displayed.login)
            }
        }
        .sheet(isPresented: $showingSheet) {
            LoginFormView()
        }
        .onReceive(loginManager.$isLoggedIn, perform: { value in
            if value {
                showingSheet = false
            }
        })
    }
}

#Preview {
    LoginButton()
}
