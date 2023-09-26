//
//  StringKeys.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 18.7.23..
//

import Foundation

struct StringKeys {
    static let opportunities = "Opportunities"
    static let prices = "Prices"
    static let history = "History"
    static let account = "Account"
    static let exchange = "Exchange"
    static let highest_bid = "Highest Bid"
    static let lowest_ask = "Lowest Ask"
    static let cross_arbitrage = "Cross Exchange Arbitrage"
    static let new_cross_arbitrage = "New Cross Arbitrage Opportunity"
    static let circular_arbitrage = "Circular Arbitrage"
    static let search = "Search"
    static let search_pairs = "Search pairs"
    static let pair_selected = "Pair: "
    static let save_opportunity = "Save Opportunity"
    static let select_exchanges = "Select exchanges to monitor:"
    
    static let coin_ticker = "coin_ticker"
    static let coin_name = "coin_name"
    static let ticker_placeholder = "[TICKER]"
    static let empty_string = ""
    static let ok = "OK"
    
    static let arbitrageFound = "Arbitrage opportunity found"
    
    struct errors {
        static let generic_error = "Error"
    }
    struct alerts {
        static let select_exchanges = "You need to select a pair and at least two exchanges."
    }
}
