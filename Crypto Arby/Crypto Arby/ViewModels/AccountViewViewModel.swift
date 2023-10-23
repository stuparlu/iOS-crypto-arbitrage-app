//
//  AccountViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation

class AccountViewViewModel: ObservableObject {
    func send() {
        BinanceRequestHandler.submitOrder(symbol: "BTCUSDT", amount: "10")
    }
}
