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
    var startPair: CurrencyPair? = nil
    
    let exchangeList = ExchangeNames.exchangesList
    
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
        recalculatePairs()
    }
    
    func selectExchange(name: String) {
        selectedExchange = name
        exchangeSelected.toggle()
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
                     ($0.quoteSymbol == startPair?.quoteSymbol && selectedPairs.last?.mainSymbol == $0.mainSymbol)))
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
    
    func saveOpportunity() {
        
    }
}
