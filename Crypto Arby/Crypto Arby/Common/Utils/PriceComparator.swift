//
//  PriceComparator.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 28.10.23..
//

import Foundation

struct PriceComparator {
    static func compareCrossPrices(for opportunity: CrossArbitrageOpportunity, exchangePrices: [BidAskData]) {
        if exchangePrices.count > 1 {
            var lowestAsk = exchangePrices.first
            var highestBid = exchangePrices.first
            for exchangePrice in exchangePrices {
                if Double(exchangePrice.askPrice) ?? 0 < Double(lowestAsk?.askPrice ?? "0") ?? 0 {
                    lowestAsk = exchangePrice
                }
                
                if Double(exchangePrice.bidPrice) ?? 0 > Double(lowestAsk?.bidPrice ?? "0") ?? 0 {
                    highestBid = exchangePrice
                }
            }
            if let highestBid = highestBid, let lowestAsk = lowestAsk, var safeHistory = opportunity.history {
                safeHistory[1] = safeHistory[0]
                if highestBid.exchange != lowestAsk.exchange && (Double(highestBid.bidPrice) ?? kCFNumberPositiveInfinity as! Double) > Double(lowestAsk.askPrice) ?? 0 {
                    safeHistory[0] = true
                    if safeHistory[0] && !safeHistory[1] {
                        NotificationHandler.sendCrossOpportunityNotificaiton(pair: lowestAsk.symbol, buyExchange: lowestAsk.exchange.capitalized, sellExchange: highestBid.exchange.capitalized)
                        DatabaseManager.shared.saveCrossHistoryData(lowestAsk: lowestAsk, highestBid: highestBid)
                        if opportunity.tradingActive {
                            Task {
                                let result = await CrossArbitrageExecutor().executeTrades(bid: highestBid, ask: lowestAsk)
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
    
    static func compareCircularPrices(for opportunity: CircularArbitrageOpportunity, exchangePrices: [BidAskData]) {
        if var safeHistory = opportunity.history {
            let startBalance = 100.0
            let tradeSteps = sortPrices(exchangePrices, opportunity: opportunity)
            let firstTicker = Cryptocurrencies.findPair(by: tradeSteps.first!.symbol)
            let firstSymbol = firstTicker.quoteSymbol
            var output = startBalance
            var ownedCurrency = firstSymbol
            for tradeStep in tradeSteps {
                let currentTicker = Cryptocurrencies.findPair(by: tradeStep.symbol)
                if ownedCurrency == currentTicker.quoteSymbol {
                    let price = Double(tradeStep.askPrice) ?? Double.infinity
                    output = output / price
                    ownedCurrency = currentTicker.mainSymbol
                } else {
                    let price = Double(tradeStep.bidPrice) ?? Double.infinity
                    output = output * price
                    ownedCurrency = currentTicker.quoteSymbol
                }
            }
            safeHistory[1] = safeHistory[0]
            if ownedCurrency == firstSymbol && output > startBalance {
                safeHistory[0] = true
                if safeHistory[0] && !safeHistory[1] {
                    let totalReturn = (((output - startBalance)/startBalance) * 100).rounded(toPlaces: 4)
                    NotificationHandler.sendCircularOpportunityNotificaiton(exchangeName: opportunity.exchangeName!, pairs: tradeSteps, returnPercent: totalReturn)
                    DatabaseManager.shared.saveCircularHistoryData(exchange: opportunity.exchangeName!, pairs: tradeSteps.map({$0.symbol}), profitPercentage: totalReturn)
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
