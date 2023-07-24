//
//  PriceResponses.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.7.23..
//

import Foundation

struct BidAskData: Identifiable {
    let id: UUID
    let exchange: String
    let symbol: String
    let bidPrice: String
    let askPrice: String
    
    init(exchange: String, symbol: String, bidPrice: Double, askPrice: Double) {
        self.id = UUID()
        self.exchange = exchange
        self.symbol = symbol
        self.bidPrice = String(bidPrice)
        self.askPrice = String(askPrice)
    }
}

let priceResponseMapper: [String: Decodable.Type] = [
    ExchangeNames.binance: BinancePriceResponse.self,
    ExchangeNames.bybit: BybitPriceResponse.self,
    ExchangeNames.bitfinex: BitfinexPriceResponse.self
]

class PriceResponse: Decodable {
    func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: StringKeys.empty_string, symbol: StringKeys.empty_string, bidPrice: 0, askPrice: 0)
    }
}
