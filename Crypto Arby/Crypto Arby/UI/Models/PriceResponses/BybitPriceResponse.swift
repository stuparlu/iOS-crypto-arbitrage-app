//
//  BybitPriceResponse.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.7.23..
//

import Foundation

class BybitResult: Decodable {
    let symbol: String
    let bidPrice: String
    let askPrice: String
    let bidQty: String
    let askQty: String
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case bidPrice
        case askPrice
        case bidQty
        case askQty
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        bidPrice = try container.decode(String.self, forKey: .bidPrice)
        askPrice = try container.decode(String.self, forKey: .askPrice)
        bidQty = try container.decode(String.self, forKey: .bidQty)
        askQty = try container.decode(String.self, forKey: .askQty)
    }
}

class BybitPriceResponse: PriceResponse {
    let result: BybitResult
    
    enum CodingKeys: String, CodingKey {
        case result
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(BybitResult.self, forKey: .result)
    }
    
    func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: exchange, symbol: ticker, bidPrice: Double(result.bidPrice)!, askPrice: Double(result.askPrice)!, bidQuantity: result.bidQty, askQuantity: result.askQty)
    }
}
