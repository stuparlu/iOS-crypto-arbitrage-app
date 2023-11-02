//
//  PriceData.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 1.11.23..
//

import Foundation

struct PriceData {
    let bidPrice: Double
    let askPrice: Double
    let bidQuantity: Double
    let askQuantity: Double
    
    init(symbol: String, bidPrice: Double, askPrice: Double, bidQuantity: Double, askQuantity: Double) {
        self.bidPrice = bidPrice
        self.askPrice = askPrice
        self.bidQuantity = bidQuantity
        self.askQuantity = askQuantity
    }
}
