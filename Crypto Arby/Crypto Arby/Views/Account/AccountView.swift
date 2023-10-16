//
//  AccountView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewViewModel()
    @StateObject var loginManager = LoginManager.shared
    var body: some View {
        Form {
            loginManager.isLoggedIn ? AnyView(AccountCardView()) : AnyView(LoginButton())
        }
    }
}

#Preview {
    AccountView()
}
