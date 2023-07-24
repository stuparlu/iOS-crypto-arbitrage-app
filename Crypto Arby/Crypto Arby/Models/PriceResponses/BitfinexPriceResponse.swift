//
//  BitfinexPriceResponse.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.7.23..
//

import Foundation

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
