//
//  PricesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation
import SwiftUI
import Combine

class PricesViewModel: ObservableObject {
    @Published var model = PricesModel()
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
        model.isNavigationViewHidden.toggle()
        model.searchText = StringKeys.placeholders.emptyString
    }
    
    func toggleNavigation() {
        model.isNavigationViewHidden.toggle()
    }
    
    func menuItemChanged(item:String) {
        stopRefreshing()
        self.model.exchangePrices = []
        model.selectedMenuOptionText = item
        SettingsManager.shared.setMonitoredCurrency(model.selectedMenuOptionText)
        scheduleRefreshing()
    }

    
    func fetchMenuItems() -> Set<String> {
        return Set(Cryptocurrencies.cryptocurrencyPairs.map({$0.searchableName}))
    }
    
    func fetchExchangePrices() -> [BidAskData] {
        return model.exchangePrices
    }
    
    @MainActor
    func fetchPrices() async {
        model.exchangePrices = []
        for exchangeName in Exchanges.names.allNames {
            let prices = await Exchanges.mapper.getRequestHandler(for: exchangeName).getBidAskData(for: model.selectedMenuOptionText)
            if let prices = prices {
                model.exchangePrices.append(prices)
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
