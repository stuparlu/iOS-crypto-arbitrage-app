//
//  PriceResponse.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.10.23..
//

import Foundation

protocol PriceResponse : Decodable {
    func fetchBidAskData(exchange: String, ticker: String) -> BidAskData
}
