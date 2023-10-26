//
//  BitfinexPriceResponse.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.7.23..
//

import Foundation

class BitfinexPriceResponse: PriceResponse {
    let bidPrice: Double
    let askPrice: Double
    let bidQuantity: String
    let askQuantity: String
    
    enum CodingKeys: String, CodingKey {
        case values
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var decodedValues = [Double]()
        while !container.isAtEnd {
            if let value = try? container.decode(Double.self) {
                decodedValues.append(value)
            }
        }
        if decodedValues.count != 10 {
            throw "Error decoding bitfinex bid ask data"
        }
        bidPrice = decodedValues[0]
        bidQuantity = String(decodedValues[1])
        askPrice = decodedValues[2]
        askQuantity = String(decodedValues[3])
    }
    
    func fetchBidAskData(exchange: String, ticker: String) -> BidAskData {
        return BidAskData(exchange: exchange, symbol: ticker, bidPrice: bidPrice, askPrice: askPrice, bidQuantity: bidQuantity, askQuantity: askQuantity)
    }
}
