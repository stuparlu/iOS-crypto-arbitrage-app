//
//  CrossArbitrageExcutor.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.10.23..
//

import Foundation

class CrossArbitrageExecutor {
    func executeTrades(bid: BidAskData, ask: BidAskData) async -> Bool {
        guard let askAmount = Double(ask.askQuantity), let bidAmount = Double(bid.bidQuantity) else {
            return false
        }
        let tradeAmount = min(askAmount, bidAmount)
        do {
            let bidResult = try await Exchanges.mapper.getRequestHandler(for: bid.exchange).submitMarketOrder(
                symbol: Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: bid.symbol), at: bid.exchange),
                side: .sell,
                amount: bidAmount)
            let askResult = try await Exchanges.mapper.getRequestHandler(for: bid.exchange).submitMarketOrder(
                symbol: Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ask.symbol), at: ask.exchange),
                side: .buy,
                amount: askAmount)
            if bidResult.isSuccessful && askResult.isSuccessful {
                DatabaseManager.shared.saveCrossTradeHistory(
                    success: true,
                    message: "Trade executed",
                    amount: tradeAmount,
                    lowestAsk: ask,
                    highestBid: bid,
                    askOrderID: askResult.orderID,
                    bidOrderID: bidResult.orderID)
                return true
            } else {
                throw "Trade Failed"
            }
        } catch {
            DatabaseManager.shared.saveCrossTradeHistory(
                success: false,
                message: "Trade execution failed",
                amount: tradeAmount,
                lowestAsk: ask,
                highestBid: bid,
                askOrderID: "none",
                bidOrderID: "none")
            return false
        }
    }
}
