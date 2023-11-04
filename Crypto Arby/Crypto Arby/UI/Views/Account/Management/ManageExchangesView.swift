//
//  ManageExchangesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.10.23..
//

import SwiftUI

struct ManageExchangesView: View {
    @StateObject var viewModel = ManageExchangesViewModel()
    
    var body: some View {
        VStack {
            Text(StringKeys.displayed.manageExchanges)
                .font(.largeTitle)
                .fontWeight(.bold)
            List(Exchanges.names.allNonWallets, id: \.self) { item in
                Button {
                    viewModel.manage(exchange: item)
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
                Text(StringKeys.displayed.manageExchange)
                    .font(.title)
                Form {
                    Text(viewModel.model.currentExchange.capitalized)
                    TextField(StringKeys.displayed.apiKey, text: $viewModel.model.apiKeyText)
                    TextField(StringKeys.displayed.apiSecret, text: $viewModel.model.apiSecretText)
                    Button {
                        viewModel.saveExchangeData()
                    } label: {
                        Text(StringKeys.displayed.saveConfiguration)
                    }
                    Button {
                        viewModel.deleteExchangeData()
                    } label: {
                        Text(StringKeys.displayed.clearConfiguration)
                    }
                    .disabled(viewModel.model.exchangeDisabled)
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
    ManageExchangesView()
}
