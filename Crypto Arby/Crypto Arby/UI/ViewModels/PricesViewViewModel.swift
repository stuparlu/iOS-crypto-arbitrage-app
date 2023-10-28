//
//  PricesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation
import SwiftUI
import Combine

class PricesViewViewModel: ObservableObject {
    @Published var selectedMenuOptionText = SettingsManager.shared.getMonitoredCurrency()
    @Published var exchangePrices: [BidAskData] = []
    @Published var isNavigationViewHidden = true
    @Published var searchText = StringKeys.empty_string
    var workItem: DispatchWorkItem?
    
    init() {
        Task {
            await self.fetchPrices()
        }
        scheduleRefreshing()
    }
    
    deinit {
        stopRefreshing()
    }
    
    func closeSearchMenu(item: String?) {
        if let safeItem = item {
            menuItemChanged(item: safeItem)
        }
        isNavigationViewHidden.toggle()
        searchText = StringKeys.empty_string
    }
    
    func menuItemChanged(item:String) {
        stopRefreshing()
        self.exchangePrices = []
        selectedMenuOptionText = item
        SettingsManager.shared.setMonitoredCurrency(selectedMenuOptionText)
        scheduleRefreshing()
    }

    
    func fetchMenuItems() -> Set<String> {
        return Set(Cryptocurrencies.cryptocurrencyPairs.map({$0.searchableName}))
    }
    
    func fetchExchangePrices() -> [BidAskData] {
        return exchangePrices
    }
    
    @MainActor
    func fetchPrices() async {
        self.exchangePrices = []
        for exchangeName in Exchanges.names.allNames {
            let prices = await PricesModel.getPricesFor(ticker: self.selectedMenuOptionText, at: exchangeName)
            if let prices = prices {
                self.exchangePrices.append(prices)
            }
        }
    }
    
    func scheduleRefreshing() {
        let queue = DispatchQueue.global()
        let interval: DispatchTimeInterval = .seconds(DefaultConfiguration.scanInterval)
        workItem = DispatchWorkItem {
            Task {
                await self.fetchPrices()
            }
            self.scheduleRefreshing()
        }
        queue.asyncAfter(deadline: .now() + interval, execute: workItem!)
    }
    
    func stopRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.workItem?.cancel()
        }
    }
}
