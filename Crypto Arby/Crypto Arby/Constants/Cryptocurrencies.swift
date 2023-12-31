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
        self.searchableName = Exchanges.mapper.getSearchableName(mainSymbol, quoteSymbol, at: StringKeys.placeholders.emptyString)
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
        CurrencyPair(mainSymbol: "MATIC", quoteSymbol: "USDT"),
        CurrencyPair(mainSymbol: "ETH", quoteSymbol: "BTC"),
        CurrencyPair(mainSymbol: "BTC", quoteSymbol: "USD"),
        CurrencyPair(mainSymbol: "POB", quoteSymbol: "SWAP.HIVE"),
        CurrencyPair(mainSymbol: "WAX", quoteSymbol: "SWAP.HIVE"),
        CurrencyPair(mainSymbol: "BEE", quoteSymbol: "SWAP.HIVE"),
        CurrencyPair(mainSymbol: "BEE", quoteSymbol: "SWAP.WAX"),
        CurrencyPair(mainSymbol: "SWAP.WAX", quoteSymbol: "BEE"),
        CurrencyPair(mainSymbol: "SWAP.WAX", quoteSymbol: "SWAP.HIVE")
    ]

    static func findPair(by name: String) -> CurrencyPair {
        return cryptocurrencyPairs.first(where: {$0.searchableName == name})!
    }
}
