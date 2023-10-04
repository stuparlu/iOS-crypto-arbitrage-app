//
//  Cryptocurrencies.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation

struct CurrencyPair: Hashable {
    let mainSymbol: String
    let quoteSymbol: String
    let searchableName: String
    
    init(mainSymbol: String, quoteSymbol: String) {
        self.mainSymbol = mainSymbol
        self.quoteSymbol = quoteSymbol
        self.searchableName = ExchangeNames.getSearchableName(mainSymbol, quoteSymbol, at: StringKeys.empty_string)
    }
}

struct Cryptocurrencies {
    static let cryptocurrencyPairs = [
        CurrencyPair(mainSymbol: "BTC", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "BTC", quoteSymbol: "USDC"),
        CurrencyPair(mainSymbol: "ETH", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "XRP", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "BNB", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "SOL", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "ADA", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "DOGE", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "TRX", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "MATIC", quoteSymbol: "USDT")
    ]

    static func findPair(by name: String) -> CurrencyPair {
        return cryptocurrencyPairs.first(where: {$0.searchableName == name})!
    }
}
