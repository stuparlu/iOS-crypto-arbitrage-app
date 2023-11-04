//
//  ManageExchangesViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.10.23..
//

import Foundation

class ManageExchangesViewModel : ObservableObject {
    @Published var model = ManageExchangesModel()
    
    func manage(exchange: String) {
        clearData()
        model.currentExchange = exchange
        loadExchangeData()
        model.showingPopover.toggle()
    }
    
    func clearData() {
        model.apiKeyText = ""
        model.apiSecretText = ""
        model.currentExchange = ""
        model.exchangeDisabled = true
    }
    
    func clearAllData() {
        Exchanges.names.allNames.forEach { item in
            KeychainManager.shared.deleteConfiguration(for: item)
        }
    }
    
    func saveExchangeData() {
        if model.apiKeyText == "" || model.apiSecretText == "" {
            return
        }
        KeychainManager.shared.save(ExchangeConfiguration(apiKey: model.apiKeyText, apiSecret: model.apiSecretText), for: model.currentExchange)
        clearData()
        model.showingPopover.toggle()
    }

    func loadExchangeData() {
        if let data = KeychainManager.shared.retriveConfiguration(forExchange: model.currentExchange) {
            model.apiKeyText = data.apiKey
            model.apiSecretText = data.apiSecret
            if model.apiKeyText != "" && model.apiSecretText != "" {
                model.exchangeDisabled = false
            }
        }
    }
    
    func deleteExchangeData() {
        KeychainManager.shared.deleteConfiguration(for: model.currentExchange)
        model.showingPopover.toggle()
    }
    
    func close() {
        model.showingPopover.toggle()
    }
}
