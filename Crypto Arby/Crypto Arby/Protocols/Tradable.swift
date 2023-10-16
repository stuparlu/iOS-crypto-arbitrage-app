//
//  Tradable.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.9.23..
//

import Foundation

protocol Tradable {
    func addPrices(price: BidAskData)
}
