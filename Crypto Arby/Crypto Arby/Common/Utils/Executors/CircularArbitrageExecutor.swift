//
//  CircularArbitrageExecutor.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.10.23..
//

import Foundation

class CircularArbitrageExecutor {
    static func executeTrades(at exchange: String, tradeSteps: [BidAskData], inputAmount: Double, startCurrency: String) async -> Bool {
        var ownedCurrency = startCurrency
        guard let balance = await Exchanges.mapper.getRequestHandler(for: exchange).getBalance(symbol: ownedCurrency) else {
            return false
        }
        var tradeAmount = min(inputAmount, balance)
        var pairs: [String] = []
        var prices: [Double] = []
        var tradeOrders: [String] = []
        let timestamp = Date.now
        for tradeStep in tradeSteps {
            let currentTicker = Cryptocurrencies.findPair(by: tradeStep.symbol)
            if ownedCurrency == currentTicker.quoteSymbol {
                let price = tradeStep.askPrice
                let quantity = tradeStep.askQuantity
                let tradeOutput = tradeAmount / price
                tradeAmount = min(tradeOutput, quantity)
                ownedCurrency = currentTicker.mainSymbol
                pairs.append(currentTicker.searchableName)
                prices.append(price)
                let orderData = OrderData(symbol: currentTicker.searchableName, type: .market, side: .buy, quantity: tradeAmount, price: price)
                let orderID = await executeOrder(for: orderData, at: exchange)
                if let orderID = orderID {
                    tradeOrders.append(orderID)
                } else {
                    DatabaseManager.shared.saveCircularTradeHistory(
                        success: false,
                        message: "Trade exectuion failed.",
                        timestamp: timestamp,
                        exchange: exchange,
                        ordersIDs: tradeOrders,
                        pairs: tradeSteps.map({$0.symbol}),
                        prices: prices)
                    return false
                }
            } else {
                let price = tradeStep.bidPrice
                let quantity = tradeStep.bidQuantity
                let tradeOutput = min(tradeAmount, quantity)
                tradeAmount = tradeOutput * price
                ownedCurrency = currentTicker.quoteSymbol
                pairs.append(currentTicker.searchableName)
                prices.append(price)
                let orderData = OrderData(symbol: currentTicker.searchableName, type: .market, side: .sell, quantity: tradeAmount, price: price)
                let orderID = await executeOrder(for: orderData, at: exchange)
                if let orderID = orderID {
                    tradeOrders.append(orderID)
                } else {
                    DatabaseManager.shared.saveCircularTradeHistory(
                        success: false,
                        message: "Trade exectuion failed.",
                        timestamp: timestamp,
                        exchange: exchange,
                        ordersIDs: tradeOrders,
                        pairs: tradeSteps.map({$0.symbol}),
                        prices: prices)
                    return false
                }
            }
        }
        DatabaseManager.shared.saveCircularTradeHistory(
            success: true,
            message: "Trades executed.",
            timestamp: timestamp,
            exchange: exchange,
            ordersIDs: tradeOrders,
            pairs: tradeSteps.map({$0.symbol}),
            prices: prices)
        return true
    }
    
    static func executeOrder(for orderData: OrderData, at exchange: String) async -> String? {
        let response = await Exchanges.mapper.getRequestHandler(for: exchange).submitTradeOrder(with: orderData)
        if response.isSuccessful {
            return response.orderID
        } else {
            return nil
        }
    }
    
    static func createTradeHistory(exchange: String, pairs: [String], prices: [Double], orders: [String]?) {
        
    }
}
