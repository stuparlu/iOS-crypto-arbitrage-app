//
//  RequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//

import Foundation

protocol RequestHandler {
   static func submitMarketOrder(symbol: String, side: TradeSide, amount: Double)
}
