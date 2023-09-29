//
//  LoginButton.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct LoginButton: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            HStack {
                Image(systemName: Symbols.user_account_icon)
                Text(StringKeys.login)
            }
        }
        .sheet(isPresented: $showingSheet) {
            LoginFormView()
        }
    }
}

#Preview {
    LoginButton()
}
