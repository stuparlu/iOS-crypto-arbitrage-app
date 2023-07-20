//
//  PriceResponses.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.7.23..
//

import Foundation

struct BidAskData {
    let exchange: String
    let symbol: String
    let bidPrice: Double
    let askPrice: Double
    
    init(exchange: String, symbol: String, bidPrice: Double, askPrice: Double) {
        self.exchange = exchange
        self.symbol = symbol
        self.bidPrice = bidPrice
        self.askPrice = askPrice
    }
}

let priceResponseMapper: [String: Decodable.Type] = [
    ExchangeNames.binance: BinancePriceResponse.self,
    ExchangeNames.bitfinex: BitfinexPriceResponse.self
]

class PriceResponse: Decodable {
    func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: StringKeys.empty_string, symbol: StringKeys.empty_string, bidPrice: 0, askPrice: 0)
    }
}

class BinancePriceResponse: PriceResponse {
    let symbol: String
    let bidPrice: String
    let askPrice: String
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case bidPrice
        case askPrice
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        bidPrice = try container.decode(String.self, forKey: .bidPrice)
        askPrice = try container.decode(String.self, forKey: .askPrice)
        try super.init(from: decoder)

    }
    
    public override func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: exchange, symbol: ticker, bidPrice: Double(self.bidPrice)!, askPrice: Double(self.askPrice)!)
    }
}

class BitfinexPriceResponse: PriceResponse {
    let bid: String
    let ask: String
    
    enum CodingKeys: String, CodingKey {
        case bid
        case ask
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bid = try container.decode(String.self, forKey: .bid)
        ask = try container.decode(String.self, forKey: .ask)
        try super.init(from: decoder)
    }
    
    public override func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: exchange, symbol: ticker, bidPrice: Double(self.bid)!, askPrice: Double(self.ask)!)
    }
}
