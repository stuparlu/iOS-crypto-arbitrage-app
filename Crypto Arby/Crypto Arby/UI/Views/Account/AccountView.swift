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
    @State private var showingManageExchanges = false

    var body: some View {
        Form {
            loginManager.isLoggedIn ? AnyView(AccountCardView()) : AnyView(LoginButton())
            Button {
                showingManageExchanges.toggle()
            } label: {
                Text(StringKeys.manageExchanges)
            }
            Button {
                viewModel.send()
            } label: {
                Text("Send")
            }
        }
        .sheet(isPresented: $showingManageExchanges) {
            ManageExchangesView()
        }

    }
}

#Preview {
    AccountView()
}
