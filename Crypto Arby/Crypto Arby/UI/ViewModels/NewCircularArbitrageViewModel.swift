//
//  NewCircularArbitrageViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.10.23..
//

import Foundation

class NewCircularArbitrageViewModel: ObservableObject {
    @Published var exchangeSelected = false
    @Published var selectedExchange = StringKeys.empty_string
    @Published var searchText = StringKeys.empty_string
    @Published var selectedPairs: [CurrencyPair] = []
    @Published var nextPairs: [CurrencyPair] = []
    @Published var saveAlertShown = false
    @Published var tradingEnabled: Bool = false
    @Published var autotradeAvailable: Bool = false
    
    var startPair: CurrencyPair? = nil
    let viewContext = PersistenceController.shared.container.viewContext
    let exchangeList = Exchanges.names.allNames
    
    init() {
        recalculatePairs()
    }
    
    func clearLast() {
        if !selectedPairs.isEmpty {
            selectedPairs.removeLast()
            recalculatePairs()
        }
    }
    
    func clearData() {
        exchangeSelected.toggle()
        selectedExchange = StringKeys.empty_string
        searchText = StringKeys.empty_string
        selectedPairs = []
        autotradeAvailable = false
        recalculatePairs()
    }
    
    func selectExchange(name: String) {
        selectedExchange = name
        exchangeSelected.toggle()
        autotradeAvailable = KeychainManager.shared.retriveConfiguration(forExchange: selectedExchange) != nil
    }
    
    func recalculatePairs() {
        if selectedPairs.isEmpty {
            nextPairs = Cryptocurrencies.cryptocurrencyPairs
            startPair = nil
        } else {
            nextPairs = Cryptocurrencies.cryptocurrencyPairs.filter {
                return (
                    !($0.searchableName == selectedPairs.last?.searchableName) &&
                    ($0.quoteSymbol == selectedPairs.last?.mainSymbol ||
                     ($0.quoteSymbol == startPair?.quoteSymbol && $0.mainSymbol == selectedPairs.last?.mainSymbol)))
            }
        }
    }
    
    func addPair(_ pair: CurrencyPair) {
        if selectedPairs.isEmpty {
            startPair = pair
        }
        selectedPairs.append(pair)
        recalculatePairs()
    }
    
    func removePair(_ pair: CurrencyPair) {
        selectedPairs.remove(at: selectedPairs.firstIndex(of: pair)!)
        if selectedPairs.isEmpty {
            startPair = nil
        }
        recalculatePairs()
    }
    
    func validateOpportunity() -> Bool {
        if selectedPairs.count < 3 || selectedPairs.first?.quoteSymbol != selectedPairs.last?.quoteSymbol{
            return false
        }
 
        for i in 0..<(selectedPairs.count - 2) {
            if selectedPairs[i].mainSymbol != selectedPairs[i + 1].quoteSymbol {
                return false
            }
        }
            return true
    }
    
    func saveOpportunity() -> Bool {
        if validateOpportunity() {
            DatabaseManager.shared.saveNewCircularOpportunity(exchangeName: selectedExchange, pairs: selectedPairs.map({$0.searchableName}), tradingActive: tradingEnabled)
            return true
        } else {
            saveAlertShown.toggle()
            return false
        }
    }
}
