//
//  NewCircularArbitrageViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.10.23..
//

import Foundation

class NewCircularArbitrageViewModel: ObservableObject {
    @Published var model = NewCircularArbitrageModel()
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        recalculatePairs()
    }
    
    func clearLast() {
        if !model.selectedPairs.isEmpty {
            model.selectedPairs.removeLast()
            recalculatePairs()
        }
    }
    
    func clearData() {
        model.exchangeSelected.toggle()
        model.selectedExchange = StringKeys.placeholders.emptyString
        model.searchText = StringKeys.placeholders.emptyString
        model.selectedPairs = []
        model.autotradeAvailable = false
        recalculatePairs()
    }
    
    func selectExchange(name: String) {
        model.selectedExchange = name
        model.exchangeSelected.toggle()
        model.autotradeAvailable = KeychainManager.shared.retriveConfiguration(forExchange: model.selectedExchange) != nil
    }
    
    func recalculatePairs() {
        if model.selectedPairs.isEmpty {
            model.nextPairs = Cryptocurrencies.cryptocurrencyPairs
            model.startPair = nil
        } else {
            model.nextPairs = Cryptocurrencies.cryptocurrencyPairs.filter {
                return (
                    !($0.searchableName == model.selectedPairs.last?.searchableName) &&
                    ($0.quoteSymbol == model.selectedPairs.last?.mainSymbol ||
                     ($0.quoteSymbol == model.startPair?.quoteSymbol && $0.mainSymbol == model.selectedPairs.last?.mainSymbol)))
            }
        }
    }
    
    func addPair(_ pair: CurrencyPair) {
        if model.selectedPairs.isEmpty {
            model.startPair = pair
        }
        model.selectedPairs.append(pair)
        recalculatePairs()
    }
    
    func removePair(_ pair: CurrencyPair) {
        model.selectedPairs.remove(at: model.selectedPairs.firstIndex(of: pair)!)
        if model.selectedPairs.isEmpty {
            model.startPair = nil
        }
        recalculatePairs()
    }
    
    func validateOpportunity() -> Bool {
        if model.selectedPairs.count < 3 || model.selectedPairs.first?.quoteSymbol != model.selectedPairs.last?.quoteSymbol{
            return false
        }
 
        for i in 0..<(model.selectedPairs.count - 2) {
            if model.selectedPairs[i].mainSymbol != model.selectedPairs[i + 1].quoteSymbol {
                return false
            }
        }
            return true
    }
    
    func saveOpportunity() -> Bool {
        if validateOpportunity() {
            DatabaseManager.shared.saveNewCircularOpportunity(exchangeName: model.selectedExchange, pairs: model.selectedPairs.map({$0.searchableName}), tradingActive: model.tradingEnabled)
            return true
        } else {
            model.saveAlertShown.toggle()
            return false
        }
    }
}
