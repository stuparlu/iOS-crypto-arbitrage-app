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
    
    let menuOptions = cryptocurrencies
    
    @Published var selectedMenuOption: Int = 0
    @Published var selectedMenuOptionText = "BTCUSDT"
    @Published var selectedOption: String?
    @Published var exchangePrices: [BidAskData] = []
    @Published var isNavigationViewHidden = true
    @Published var searchText = StringKeys.empty_string
    private var timer: AnyCancellable?
    
    init() {
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
        exchangePrices = []
        selectedMenuOptionText = item
        startTimer()
    }
    
    func fetchMenuItems() -> Set<String> {
        return cryptocurrencies
    }
    
    func fetchExchangePrices() -> [BidAskData] {
        return exchangePrices
    }
    
    func startTimer() {
        timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect().sink { _ in
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
