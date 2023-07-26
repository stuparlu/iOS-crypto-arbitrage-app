//
//  ExchangeUrlMapper.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.7.23..
//

import Foundation

struct ExchangeUrlMapper {
    static let exchangeUrls = [
        ExchangeNames.binance: "https://api.binance.com/api/v3/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
        ExchangeNames.bybit: "https://api.bybit.com/spot/v3/public/quote/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
        ExchangeNames.bitfinex: "https://api.bitfinex.com/v1/pubticker/\(StringKeys.ticker_placeholder)"
    ]
    
    static func getExchangeURL(exchange: String, ticker: String) -> String {
        return exchangeUrls[exchange]!.replacingOccurrences(of: StringKeys.ticker_placeholder, with: ticker)
    }
}
