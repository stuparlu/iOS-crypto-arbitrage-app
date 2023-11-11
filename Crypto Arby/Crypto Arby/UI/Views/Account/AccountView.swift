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
                    viewModel.toggleShowingExchanges()
                } label: {
                    Text(StringKeys.displayed.manageExchanges)
                }
                Button {
                    viewModel.toggleShowingWallets()
                } label: {
                    Text(StringKeys.displayed.manageWallets)
                }
            }
            Section(header: Text(StringKeys.displayed.viewConfiguration)) {
                Text(StringKeys.displayed.percentageThreshold)
                    .foregroundStyle(ThemeManager.accentColor)
                    .lineLimit(1)
                TextField(
                    StringKeys.placeholders.emptyString,
                    text: viewModel.percentageThreshold
                )
                .foregroundStyle(ThemeManager.accentColor)
                .keyboardType(.decimalPad)
                Button {
                    viewModel.savePercentageThreshold()
                } label: {
                    Text(StringKeys.displayed.saveConfiguration)
                }
            }
        }
        .sheet(isPresented: viewModel.showingManageExchanges) {
            ManageExchangesView()
        }
        .sheet(isPresented: viewModel.showingManageWallets) {
            ManageWalletsView()
        }
    }
}

#Preview {
    AccountView()
}
