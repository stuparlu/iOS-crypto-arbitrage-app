//
//  AccountView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @StateObject var loginManager = LoginManager.shared

    
    var body: some View {
        Form {
            Section(header: Text(StringKeys.displayed.account)) {
                loginManager.isLoggedIn ? AnyView(AccountCardView()) : AnyView(LoginButton())
                Button {
                    viewModel.model.showingManageExchanges.toggle()
                } label: {
                    Text(StringKeys.displayed.manageExchanges)
                }
                Button {
                    viewModel.model.showingManageWallets.toggle()
                } label: {
                    Text(StringKeys.displayed.manageWallets)
                }
            }
            Section(header: Text(StringKeys.displayed.viewConfiguration)) {
                Text(StringKeys.displayed.percentageThreshold)
                    .lineLimit(1)
                TextField(
                    StringKeys.placeholders.emptyString,
                    text: $viewModel.model.percentageThreshold
                )
                .keyboardType(.decimalPad)
                Button {
                    viewModel.savePercentageThreshold()
                } label: {
                    Text(StringKeys.displayed.saveConfiguration)
                }
            }
            
            Button {
                viewModel.send()
            } label: {
                Text("Send")
            }
        }
        .sheet(isPresented: $viewModel.model.showingManageExchanges) {
            ManageExchangesView()
        }
        .sheet(isPresented: $viewModel.model.showingManageWallets) {
            ManageWalletsView()
        }
    }
}

#Preview {
    AccountView()
}
