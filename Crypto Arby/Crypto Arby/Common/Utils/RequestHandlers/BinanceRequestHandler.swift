//
//  BinanceRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 21.10.23..
//

import Foundation

struct BinanceMarketRequestBody: Codable {
    var type: String
    var symbol: String
    var amount: String
}

struct BinanceRequestHandler {}
    
