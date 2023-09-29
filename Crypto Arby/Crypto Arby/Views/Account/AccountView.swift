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
        loginManager.isLoggedIn ? AnyView(Text("you")) : AnyView(LoginButton())

    }
}

#Preview {
    AccountView()
}
