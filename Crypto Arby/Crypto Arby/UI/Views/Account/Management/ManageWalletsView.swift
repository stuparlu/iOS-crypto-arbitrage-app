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
            Text(StringKeys.displayed.manageWallets)
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
                Text(StringKeys.displayed.clearAllKeys)
            }
            
        }
        .popover(isPresented: $viewModel.model.showingPopover) {
            VStack {
                Text(StringKeys.displayed.manageWallet)
                    .font(.title)
                Form {
                    Text(viewModel.model.currentWallet.capitalized)
                    TextField(StringKeys.displayed.accountName, text: $viewModel.model.accountName)
                    TextField(StringKeys.displayed.privateKey, text: $viewModel.model.privateKeyText)
                    Button {
                        viewModel.saveWalletData()
                    } label: {
                        Text(StringKeys.displayed.saveConfiguration)
                    }
                    Button {
                        viewModel.deleteWalletData()
                    } label: {
                        Text(StringKeys.displayed.clearConfiguration)
                    }
                    .disabled(viewModel.model.walletDisabled)
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
