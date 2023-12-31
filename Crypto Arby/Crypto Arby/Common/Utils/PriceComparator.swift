//
//  PriceComparator.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 28.10.23..
//

import Foundation

struct PriceComparator {
    static func compareCrossPrices(for opportunity: CrossArbitrageOpportunity, exchangePrices: [BidAskData]) async {
        if exchangePrices.count > 1 {
            let lowestAsk = exchangePrices.min(by: {$0.askPrice < $1.askPrice})
            let highestBid = exchangePrices.max(by: {$0.bidPrice > $1.bidPrice})
            let percentageThreshold = SettingsManager.shared.getPercentageThreshold() / 100
            if let highestBid = highestBid, let lowestAsk = lowestAsk, var safeHistory = opportunity.history {
                safeHistory[1] = safeHistory[0]
                let comparePrice = lowestAsk.askPrice
                if highestBid.exchange != lowestAsk.exchange && highestBid.bidPrice > comparePrice + (comparePrice * percentageThreshold) {
                    safeHistory[0] = true
                    if safeHistory[0] && !safeHistory[1] {
                        NotificationHandler.sendCrossOpportunityNotificaiton(pair: lowestAsk.symbol, buyExchange: lowestAsk.exchange.capitalized, sellExchange: highestBid.exchange.capitalized)
                        DatabaseManager.shared.saveCrossHistoryData(lowestAsk: lowestAsk, highestBid: highestBid)
                        if opportunity.tradingActive {
                            let result = await CrossArbitrageExecutor.executeTrades(bid: highestBid, ask: lowestAsk)
                            if !result {
                                opportunity.tradingActive = false
                                DispatchQueue.main.async {
                                    do {
                                        try opportunity.viewContext.save()
                                    } catch {}
                                }
                            }
                        }
                    }
                } else {
                    safeHistory[0] = false
                }
                opportunity.history = safeHistory
                do {
                    try opportunity.viewContext.save()
                } catch {}
            }
        }
    }
    
    static func sortPrices(_ prices: [BidAskData], opportunity: CircularArbitrageOpportunity) -> [BidAskData] {
        return prices.sorted(by: {(bidask1, bidask2) in
            guard let index1 = opportunity.selectedPairs?.firstIndex(of: bidask1.symbol),
                  let index2 = opportunity.selectedPairs?.firstIndex(of: bidask2.symbol) else {
                return false
            }
            return index1 < index2
        })
    }
    
    static func compareCircularPrices(for opportunity: CircularArbitrageOpportunity, exchangePrices: [BidAskData]) async {
        if var safeHistory = opportunity.history {
            let startBalance = 100.0
            let tradeSteps = sortPrices(exchangePrices, opportunity: opportunity)
            let firstTicker = Cryptocurrencies.findPair(by: tradeSteps.first!.symbol)
            let firstSymbol = firstTicker.quoteSymbol
            var output = startBalance
            var ownedCurrency = firstSymbol
            var tradeAmount = Double.infinity
            for tradeStep in tradeSteps {
                let currentTicker = Cryptocurrencies.findPair(by: tradeStep.symbol)
                if ownedCurrency == currentTicker.quoteSymbol {
                    let price = tradeStep.askPrice
                    let quantity = tradeStep.askQuantity
                    let tradeOutput = tradeAmount / price
                    tradeAmount = min(tradeOutput, quantity)
                    output = output / price
                    ownedCurrency = currentTicker.mainSymbol
                } else {
                    let price = tradeStep.bidPrice
                    let quantity = tradeStep.bidQuantity
                    let tradeOutput = min(tradeAmount, quantity)
                    tradeAmount = tradeOutput * price
                    output = output * price
                    ownedCurrency = currentTicker.quoteSymbol
                }
            }
            safeHistory[1] = safeHistory[0]
            let percentageThreshold = SettingsManager.shared.getPercentageThreshold()  / 100
            if ownedCurrency == firstSymbol && output > startBalance + (startBalance * (percentageThreshold / 100))  {
                safeHistory[0] = true
                if safeHistory[0] && !safeHistory[1] {
                    let totalReturn = (((output - startBalance)/startBalance) * 100).rounded(toPlaces: 4)
                    NotificationHandler.sendCircularOpportunityNotificaiton(exchangeName: opportunity.exchangeName!, pairs: tradeSteps, returnPercent: totalReturn)
                    DatabaseManager.shared.saveCircularHistoryData(exchange: opportunity.exchangeName!, pairs: tradeSteps.map({$0.symbol}), profitPercentage: totalReturn)
                    if opportunity.tradingActive {
                        let result = await CircularArbitrageExecutor.executeTrades(at: opportunity.exchangeName!,tradeSteps: tradeSteps, inputAmount: tradeAmount, startCurrency: ownedCurrency)
                        if !result {
                            opportunity.tradingActive = false
                            DispatchQueue.main.async {
                                do {
                                    try opportunity.viewContext.save()
                                } catch {}
                            }
                        }
                    }
                }
            } else {
                safeHistory[0] = false
            }
            opportunity.history = safeHistory
            do {
                try opportunity.viewContext.save()
            } catch {}
        }
    }
}
