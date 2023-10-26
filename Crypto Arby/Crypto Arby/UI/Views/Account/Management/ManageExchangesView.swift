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
            Text(StringKeys.manageExchanges)
                .font(.largeTitle)
                .fontWeight(.bold)
            List(Exchanges.names.allNames, id: \.self) { item in
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
                Text(StringKeys.clearAllKeys)
            }
        }
        .popover(isPresented: $viewModel.showingPopover) {
            VStack {
                Text(StringKeys.manageExchange)
                    .font(.title)
                Form {
                    Text(viewModel.currentExchange.capitalized)
                    TextField(StringKeys.apiKey, text: $viewModel.apiKeyText)
                    TextField(StringKeys.apiSecret, text: $viewModel.apiSecretText)
                    Button {
                        viewModel.saveExchangeData()
                    } label: {
                        Text(StringKeys.saveConfiguration)
                    }
                    Button {
                        viewModel.deleteExchangeData()
                    } label: {
                        Text(StringKeys.clearConfiguration)
                    }
                    .disabled(viewModel.exchangeDisabled)
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