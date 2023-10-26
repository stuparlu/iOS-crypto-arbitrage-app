//
//  CrossArbitrageExcutor.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.10.23..
//

import Foundation

class CrossArbitrageExecutor {
    func executeTrades(bid: BidAskData, ask: BidAskData) {
        guard let askAmount = Double(ask.askQuantity), let bidAmount = Double(bid.bidQuantity) else {
            return
        }
        let tradeAmount = min(askAmount, bidAmount)
        Exchanges.mapper.getRequestHandler(for: bid.exchange).submitMarketOrder(
            symbol: Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: bid.symbol), at: bid.exchange),
            side: .sell,
            amount: tradeAmount)
        Exchanges.mapper.getRequestHandler(for: bid.exchange).submitMarketOrder(
            symbol: Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ask.symbol), at: ask.exchange),
            side: .buy,
            amount: tradeAmount)
    }
}
