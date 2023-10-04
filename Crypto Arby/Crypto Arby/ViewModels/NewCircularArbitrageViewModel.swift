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
    
    let exchangeList = ExchangeNames.exchangesList
    
    init() {
        recalculatePairs()
    }
    
    func selectExchange(name: String) {
        selectedExchange = name
        exchangeSelected.toggle()
    }
    
    func recalculatePairs() {
        if selectedPairs.isEmpty {
            nextPairs = Cryptocurrencies.cryptocurrencyPairs
        } else {
            nextPairs = Cryptocurrencies.cryptocurrencyPairs.filter { $0.quoteSymbol == selectedPairs.last?.mainSymbol }
        }
    }
    
    func addPair(_ pair: CurrencyPair) {
        selectedPairs.append(pair)
        recalculatePairs()
    }

    func removePair(_ pair: CurrencyPair) {
        selectedPairs.remove(at: selectedPairs.firstIndex(of: pair)!)
        recalculatePairs()
    }
}
