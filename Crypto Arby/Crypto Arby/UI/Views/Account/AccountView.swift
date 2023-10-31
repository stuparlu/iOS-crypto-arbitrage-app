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
    @State private var showingManageWallets = false
    
    var body: some View {
        Form {
            Section(header: Text(StringKeys.account)) {
                loginManager.isLoggedIn ? AnyView(AccountCardView()) : AnyView(LoginButton())
                Button {
                    showingManageExchanges.toggle()
                } label: {
                    Text(StringKeys.manageExchanges)
                }
                Button {
                    showingManageWallets.toggle()
                } label: {
                    Text(StringKeys.manageWallets)
                }
            }
            Section(header: Text(StringKeys.viewConfiguration)) {
                Text(StringKeys.percentageThreshold)
                    .lineLimit(1)
                TextField(
                    StringKeys.empty_string,
                    text: $viewModel.percentageThreshold
                )
                .keyboardType(.decimalPad)
                Button {
                    viewModel.savePercentageThreshold()
                } label: {
                    Text(StringKeys.saveConfiguration)
                }
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
        .sheet(isPresented: $showingManageWallets) {
            ManageWalletsView()
        }
    }
}

#Preview {
    AccountView()
}
