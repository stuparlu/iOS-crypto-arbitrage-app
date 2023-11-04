//
//  NewCrossArbitrageViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.7.23..
//

import Foundation

class NewCrossArbitrageViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var model = NewCrossArbitrageModel()
    
    func selectPair(pairName: String) {
        model.selectedPair = Cryptocurrencies.findPair(by: pairName).searchableName
        model.pairSelected.toggle()
    }
    
    func getTickers() -> [String] {
        return Cryptocurrencies.cryptocurrencyPairs.map({$0.searchableName})
    }
    
    func toggleExchange(exchangeName: String) {
        if model.selectedExchanges.contains(exchangeName) {
            model.selectedExchanges.removeAll() { $0 == exchangeName}
        } else {
            model.selectedExchanges.append(exchangeName)
        }
        for exchange in model.selectedExchanges {
            guard KeychainManager.shared.retriveConfiguration(forExchange: exchange) != nil else {
                model.autotradeAvailable = false
                break
            }
        }
        model.autotradeAvailable = true
    }
    
    func isExchangeEnabled(exchangeName:String) -> Bool {
        return model.selectedExchanges.contains(exchangeName)
    }
    
    func saveButtonPressed() -> Bool{
        if model.selectedPair == StringKeys.placeholders.emptyString || model.selectedExchanges.count <= 1 {
            model.showAlert.toggle()
            return false
        } else {
            saveNewOpportunity()
            return true
        }
    }
    
    func saveNewOpportunity() {
        DatabaseManager.shared.saveNewCrossOpportunity(pairName: model.selectedPair, exchanges: model.selectedExchanges, tradingActive: model.tradingEnabled)
    }
}
