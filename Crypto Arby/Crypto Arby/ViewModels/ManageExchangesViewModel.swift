//
//  ManageExchangesViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.10.23..
//

import Foundation

class ManageExchangesViewModel : ObservableObject {
    @Published var showingPopover = false
    @Published var apiKeyText = ""
    @Published var apiSecretText = ""
    @Published var exchangeDisabled = false
    var currentExchange = ""
    
    func manage(exchange: String) {
        clearData()
        currentExchange = exchange
        loadExchangeData()
        showingPopover.toggle()
    }
    
    func clearData() {
        apiKeyText = ""
        apiSecretText = ""
        currentExchange = ""
        exchangeDisabled = true
    }
    
    func clearAllData() {
        ExchangeNames.exchangesList.forEach { item in
            KeychainManager.shared.deleteConfiguration(for: item)
        }
    }
    
    func saveExchangeData() {
        if apiKeyText == "" || apiSecretText == "" {
            return
        }
        KeychainManager.shared.save(ExchangeConfiguration(apiKey: apiKeyText, apiSecret: apiSecretText), for: currentExchange)
        clearData()
        showingPopover.toggle()
    }

    func loadExchangeData() {
        if let data = KeychainManager.shared.retriveConfiguration(for: currentExchange) {
            apiKeyText = data.apiKey
            apiSecretText = data.apiSecret
            if apiKeyText != "" && apiSecretText != "" {
                exchangeDisabled = false
            }
        }
    }
    
    func deleteExchangeData() {
        KeychainManager.shared.deleteConfiguration(for: currentExchange)
        showingPopover.toggle()
    }
}
