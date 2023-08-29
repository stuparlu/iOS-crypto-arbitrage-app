//
//  PricesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation
import SwiftUI

class PricesViewViewModel: ObservableObject {
    let menuOptions = cryptocurrencies
    let pricesModel = PricesModel()
    
    @Published var selectedMenuOption: Int = 0
    @Published var selectedMenuOptionText = "BTCUSDT"
    @Published var selectedOption: String?
    @Published var exchangePrices: [BidAskData] = []
    @Published var isNavigationViewHidden = true
    @Published var searchText = StringKeys.empty_string
    
    
    init() {
        pricesModel.getPricesForTicker(ticker: selectedMenuOptionText, delegate: self)
    }
    
    func closeSearchMenu(item: String?) {
        if let safeItem = item {
            menuItemChanged(item: safeItem)
        }
        isNavigationViewHidden.toggle()
        searchText = StringKeys.empty_string
    }
    
    func menuItemChanged(item:String) {
        exchangePrices = []
        selectedMenuOptionText = item
        pricesModel.getPricesForTicker(ticker: item, delegate: self)
    }
    
    func fetchMenuItems() -> Set<String> {
        return cryptocurrencies
    }
    
    func fetchExchangePrices() -> [BidAskData] {
        return exchangePrices
    }
    
}
