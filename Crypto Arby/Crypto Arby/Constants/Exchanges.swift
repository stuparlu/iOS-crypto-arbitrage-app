//
//  Exchanges.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.7.23..
//

import Foundation

struct ExchangeNames {
    static let binance = "binance"
    static let bybit = "bybit"
    static let bitfinex = "bitfinex"
    
    static let exchangesList = [
        binance,
        bybit,
        bitfinex
    ]
    
    struct urlMapper {
        static let exchangeUrls = [
            ExchangeNames.binance: "https://api.binance.com/api/v3/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            ExchangeNames.bybit: "https://api.bybit.com/spot/v3/public/quote/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            ExchangeNames.bitfinex: "https://api.bitfinex.com/v1/pubticker/\(StringKeys.ticker_placeholder)"
        ]
        
        static func getExchangeURL(exchange: String, ticker: String) -> String {
            return exchangeUrls[exchange]!.replacingOccurrences(of: StringKeys.ticker_placeholder, with: ticker)
        }
    }
    
    static func getSearchableName(for pair: CurrencyPair, at exchange: String) -> String {
        getSearchableName(pair.mainSymbol, pair.quoteSymbol, at: exchange)
    }
    
    static func getSearchableName(_ mainSymbol: String, _ quoteSymbol: String, at exchange: String) -> String {
        switch exchange {
        case binance, bybit, bitfinex:
            return "\(mainSymbol)\(quoteSymbol)"
        default:
            return "\(mainSymbol)\(quoteSymbol)"
        }
    }
}
