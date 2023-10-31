//
//  BitfinexCodables.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 31.10.23..
//

import Foundation

struct BitfinexMarketRequestBody: Codable {
    var type: String
    var symbol: String
    var amount: String
}

struct BitfinexBalanceRequestBody: Codable {
    var symbol: String
    var dir: Int
    var rate: String
    var type: String
}
