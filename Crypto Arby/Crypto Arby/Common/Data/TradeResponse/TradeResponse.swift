//
//  TradeResponse.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.10.23..
//

import Foundation

struct TradeResponse {
    let isSuccessful: Bool
    let orderID: String
    static func getNullResponse() -> TradeResponse {
        return TradeResponse(isSuccessful: false, orderID: "")
    }
}
