//
//  CrossArbitrageExcutor.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.10.23..
//

import Foundation

class CrossArbitrageExecutor {
    static func executeTrades(bid: BidAskData, ask: BidAskData) async -> Bool {
        let currencies = Cryptocurrencies.findPair(by: bid.symbol)
        let mainBalance = await Exchanges.mapper.getRequestHandler(for: bid.exchange).getBalance(symbol:         Exchanges.mapper.getSearchableName(currencies.mainSymbol, at: bid.exchange))
        let quoteBalance = await Exchanges.mapper.getRequestHandler(for: bid.exchange).getBalance(symbol:         Exchanges.mapper.getSearchableName(currencies.quoteSymbol, at: bid.exchange))
        guard let mainBalance = mainBalance, let quoteBalance = quoteBalance else {
            return false
        }
        let tradeAmount = min(min(min(ask.askQuantity, bid.bidQuantity), mainBalance), quoteBalance / ask.askPrice)
        let buyOrder = OrderData(symbol: ask.symbol, type: .market, side: .buy, quantity: tradeAmount, price: ask.askPrice)
        let sellOrder = OrderData(symbol: bid.symbol, type: .market, side: .buy, quantity: tradeAmount, price: ask.bidPrice)
        let askResult = await Exchanges.mapper.getRequestHandler(for: ask.exchange).submitTradeOrder(with: buyOrder)
        let bidResult = await Exchanges.mapper.getRequestHandler(for: bid.exchange).submitTradeOrder(with: sellOrder)
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
            DatabaseManager.shared.saveCrossTradeHistory(
                success: false,
                message: "Trade execution failed.",
                amount: tradeAmount,
                lowestAsk: ask,
                highestBid: bid,
                askOrderID: "none",
                bidOrderID: "none")
            return false
        }
    }
}
