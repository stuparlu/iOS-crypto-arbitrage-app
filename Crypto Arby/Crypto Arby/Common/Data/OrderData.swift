//
//  OrderData.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 1.11.23..
//

import Foundation

struct OrderData {
    let symbol: String
    let type: OrderType
    let side: TradeSide
    let quantity: Double
    let price: Double
}
