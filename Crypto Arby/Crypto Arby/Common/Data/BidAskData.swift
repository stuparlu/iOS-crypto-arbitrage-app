//
//  BidAskData.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.10.23..
//

import Foundation

struct BidAskData: Identifiable {
    let id: UUID
    let exchange: String
    let symbol: String
    let bidPrice: String
    let askPrice: String
    let bidQuantity: String
    let askQuantity: String
    
    init(exchange: String, symbol: String, bidPrice: Double, askPrice: Double, bidQuantity: String, askQuantity: String) {
        self.id = UUID()
        self.exchange = exchange
        self.symbol = symbol
        self.bidPrice = String(bidPrice)
        self.askPrice = String(askPrice)
        self.bidQuantity = bidQuantity
        self.askQuantity = askQuantity
    }
}
