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

struct ExchangeParameters {
    let name : String
    let requestHandler: RequestHandler.Type
    let responseType: PriceResponse.Type
    let getSymbolUrl: String
    let symbolFormat: String
    let apiEndpoint: String
    let submitOrderPath: String
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
    
    struct parameters {
        static let binance = ExchangeParameters(
            name: names.binance,
            requestHandler: BinanceRequestHandler.self,
            responseType: BinancePriceResponse.self,
            getSymbolUrl: "https://api.binance.com/api/v3/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            symbolFormat: "\(StringKeys.main_placeholder)\(StringKeys.quote_placeholder)",
            apiEndpoint: "https://testnet.binance.vision",
            submitOrderPath: "/api/v3/order"
        )
        static let bybit = ExchangeParameters(
            name: names.bybit,
            requestHandler: BybitRequestHandler.self,
            responseType: BybitPriceResponse.self,
            getSymbolUrl: "https://api.bybit.com/spot/v3/public/quote/ticker/bookTicker?symbol=\(StringKeys.ticker_placeholder)",
            symbolFormat: "\(StringKeys.main_placeholder)\(StringKeys.quote_placeholder)",
            apiEndpoint: "https://api-testnet.bybit.com/",
            submitOrderPath: "/v5/order/create"
        )
        static let bitfinex = ExchangeParameters(
            name: names.bitfinex,
            requestHandler: BitfinexRequestHandler.self,
            responseType: BitfinexPriceResponse.self,
            getSymbolUrl: "https://api-pub.bitfinex.com/v2/ticker/\(StringKeys.ticker_placeholder)",
            symbolFormat: "t\(StringKeys.main_placeholder)\(StringKeys.quote_placeholder)",
            apiEndpoint: "https://api.bitfinex.com/",
            submitOrderPath: "v2/auth/w/order/submit"
        )
    }
    
    struct mapper {
        static func getParameters(for exchange: String) -> ExchangeParameters {
            switch exchange {
            case names.binance:
                return parameters.binance
            case names.bybit:
                return parameters.bybit
            case names.bitfinex:
                return parameters.bitfinex
            default:
                return parameters.binance
            }
        }
        
        static func getSymbolUrl(for exchange: String, ticker: String) -> String {
            return getParameters(for: exchange).getSymbolUrl.replacingOccurrences(of: StringKeys.ticker_placeholder, with: ticker)
        }
        
        static func getResponseType(for exchange: String) -> PriceResponse.Type {
            return getParameters(for: exchange).responseType
        }
        
        static func getSearchableName(for pair: CurrencyPair, at exchange: String) -> String {
            getSearchableName(pair.mainSymbol, pair.quoteSymbol, at: exchange)
        }
        
        static func getSearchableName(_ mainSymbol: String, _ quoteSymbol: String, at exchange: String) -> String {
            return getParameters(for: exchange).symbolFormat
                .replacingOccurrences(of: StringKeys.main_placeholder, with: mainSymbol)
                .replacingOccurrences(of: StringKeys.quote_placeholder, with: quoteSymbol)
        }
        
        static func getRequestHandler(for exchange: String) -> RequestHandler.Type {
            return getParameters(for: exchange).requestHandler
        }
    }
}
