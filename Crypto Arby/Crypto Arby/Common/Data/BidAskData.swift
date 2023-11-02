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
    let bidPrice: Double
    let askPrice: Double
    let bidQuantity: Double
    let askQuantity: Double
    
    init(exchange: String, symbol: String, bidPrice: Double, askPrice: Double, bidQuantity: Double, askQuantity: Double) {
        self.id = UUID()
        self.exchange = exchange
        self.symbol = symbol
        self.bidPrice = bidPrice
        self.askPrice = askPrice
        self.bidQuantity = bidQuantity
        self.askQuantity = askQuantity
    }
}
