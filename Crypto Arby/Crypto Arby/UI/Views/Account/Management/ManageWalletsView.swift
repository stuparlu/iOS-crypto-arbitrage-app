//
//  ManageWalletsView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 31.10.23..
//

import SwiftUI

struct ManageWalletsView: View {
    @StateObject var viewModel = ManageWalletsViewModel()
    
    var body: some View {
        VStack {
            Text(StringKeys.manageWallets)
                .font(.largeTitle)
                .fontWeight(.bold)
            List(Exchanges.wallets.allNames, id: \.self) { item in
                Button {
                    viewModel.manage(wallet: item)
                } label: {
                    Text(item.capitalized)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                viewModel.clearAllData()
            } label: {
                Text(StringKeys.clearAllKeys)
            }
        }
        .popover(isPresented: $viewModel.showingPopover) {
            VStack {
                Text(StringKeys.manageWallet)
                    .font(.title)
                Form {
                    Text(viewModel.currentWallet.capitalized)
                    TextField(StringKeys.accountName, text: $viewModel.accountName)
                    TextField(StringKeys.privateKey, text: $viewModel.privateKeyText)
                    Button {
                        viewModel.saveWalletData()
                    } label: {
                        Text(StringKeys.saveConfiguration)
                    }
                    Button {
                        viewModel.deleteWalletData()
                    } label: {
                        Text(StringKeys.clearConfiguration)
                    }
                    .disabled(viewModel.walletDisabled)
                }
                .background(ThemeManager.backgroundColor)
                .scrollContentBackground(.hidden)
            }
            .padding(.vertical)
        }
        .padding(.vertical)
    }
}

#Preview {
    ManageWalletsView()
}
