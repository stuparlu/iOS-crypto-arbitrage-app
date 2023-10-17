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
    var currentExchange = ""
    
    func manage(exchange: String) {
        showingPopover.toggle()
        clearData()
        currentExchange = exchange
        loadExchangeData()
    }
    
    func clearData() {
        apiKeyText = ""
        apiSecretText = ""
        currentExchange = ""
    }
    
    func saveExchangeData() {
        KeychainManager.shared.save(ExchangeConfiguration(apiKey: apiKeyText, apiSecret: apiSecretText), for: currentExchange)
        clearData()
        showingPopover.toggle()
    }

    func loadExchangeData() {
        if let data = KeychainManager.shared.retriveConfiguration(for: currentExchange) {
            apiKeyText = data.apiKey
            apiSecretText = data.apiSecret
        }
    }
}
