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
        for tradeStep in tradeSteps {
            let currentTicker = Cryptocurrencies.findPair(by: tradeStep.symbol)
            if ownedCurrency == currentTicker.quoteSymbol {
                let price = Double(tradeStep.askPrice) ?? Double.infinity
                let quantity = Double(tradeStep.askQuantity)!
                let tradeOutput = tradeAmount / price
                tradeAmount = min(tradeOutput, quantity)
                ownedCurrency = currentTicker.mainSymbol
                pairs.append(currentTicker.searchableName)
                prices.append(price)
                let orderID = await executeOrder(for: exchange, symbol: currentTicker, side: .buy, amount: tradeAmount)
                if let orderID = orderID {
                    tradeOrders.append(orderID)
                } else {
                    return false
                }
            } else {
                let price = Double(tradeStep.bidPrice) ?? Double.infinity
                let quantity = Double(tradeStep.bidQuantity)!
                let tradeOutput = min(tradeAmount, quantity)
                tradeAmount = tradeOutput * price
                ownedCurrency = currentTicker.quoteSymbol
                pairs.append(currentTicker.searchableName)
                prices.append(price)
                let orderID = await executeOrder(for: exchange, symbol: currentTicker, side: .sell, amount: tradeAmount)
                if let orderID = orderID {
                    tradeOrders.append(orderID)
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    static func executeOrder(for exchange: String, symbol: CurrencyPair, side: TradeSide, amount: Double) async -> String? {
        do {
            let response = try await Exchanges.mapper.getRequestHandler(for: exchange).submitMarketOrder(symbol: Exchanges.mapper.getSearchableName(for: symbol, at: exchange), side: side, amount: amount)
            if response.isSuccessful {
                return response.orderID
            } else {
                throw "Error submitting order."
            }
        } catch {
            return nil
        }
    }
    
    static func createTradeHistory(exchange: String, pairs: [String], prices: [Double], orders: [String]?) {
        
    }
}
