//
//  PricesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation
import SwiftUI
import Combine

class PricesViewViewModel: ObservableObject, Tradable {
    @Published var selectedMenuOptionText = SettingsManager.shared.getMonitoredCurrency()
    @Published var exchangePrices: [BidAskData] = []
    @Published var isNavigationViewHidden = true
    @Published var searchText = StringKeys.empty_string
    private var timer: AnyCancellable?
    
    init() {
        PricesModel.getPricesForTicker(ticker: self.selectedMenuOptionText, delegate: self)
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    func closeSearchMenu(item: String?) {
        if let safeItem = item {
            menuItemChanged(item: safeItem)
        }
        isNavigationViewHidden.toggle()
        searchText = StringKeys.empty_string
    }
    
    func menuItemChanged(item:String) {
        stopTimer()
        PricesModel.getPricesForTicker(ticker: self.selectedMenuOptionText, delegate: self)
        exchangePrices = []
        selectedMenuOptionText = item
        SettingsManager.shared.setMonitoredCurrency(selectedMenuOptionText)
        startTimer()
    }
    
    func fetchMenuItems() -> Set<String> {
        return Set(Cryptocurrencies.cryptocurrencyPairs.map({$0.searchableName}))
    }
    
    func fetchExchangePrices() -> [BidAskData] {
        return exchangePrices
    }
    
    func startTimer() {
        timer = Timer.publish(every: DefaultConfiguration.scanInterval, on: .main, in: .common).autoconnect().sink { _ in
            PricesModel.getPricesForTicker(ticker: self.selectedMenuOptionText, delegate: self)
            self.exchangePrices = []
        }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
    
    func addPrices(price: BidAskData) {
        self.exchangePrices.append(price)
    }
}
