//
//  Exchanges.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.7.23..
//

import Foundation

struct ExchangeConfiguration : Codable {
    let apiKey: String
    let apiSecret: String
}

struct Exchanges {
    
    struct names {
        static let binance = "binance"
        static let bybit = "bybit"
        static let bitfinex = "bitfinex"
        
        static let allNames = [
            binance,
            bybit,
            bitfinex
        ]
    }
    
    struct urlMapper {
        static let exchangeUrls = [
            names.binance: "https://api.binance.com/api/v3/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            names.bybit: "https://api.bybit.com/spot/v3/public/quote/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            names.bitfinex: "https://api-pub.bitfinex.com/v2/ticker/\(StringKeys.ticker_placeholder)"
        ]
        
        static func getExchangeURL(exchange: String, ticker: String) -> String {
            return exchangeUrls[exchange]!.replacingOccurrences(of: StringKeys.ticker_placeholder, with: ticker)
        }
    }
    
    struct priceResponseMapper {
        static let priceResponses: [String: PriceResponse.Type] = [
            Exchanges.names.binance: BinancePriceResponse.self,
            Exchanges.names.bybit: BybitPriceResponse.self,
            Exchanges.names.bitfinex: BitfinexPriceResponse.self
        ]
        
        static func getResponse(for exchange: String) -> PriceResponse.Type? {
            return priceResponses[exchange] ?? nil
        }
    }
    
    static func getSearchableName(for pair: CurrencyPair, at exchange: String) -> String {
        getSearchableName(pair.mainSymbol, pair.quoteSymbol, at: exchange)
    }
    
    static func getSearchableName(_ mainSymbol: String, _ quoteSymbol: String, at exchange: String) -> String {
        switch exchange {
        case names.binance, names.bybit:
            return "\(mainSymbol)\(quoteSymbol)"
        case names.bitfinex:
            return "t\(mainSymbol)\(quoteSymbol)"
        default:
            return "\(mainSymbol)\(quoteSymbol)"
        }
    }
}
