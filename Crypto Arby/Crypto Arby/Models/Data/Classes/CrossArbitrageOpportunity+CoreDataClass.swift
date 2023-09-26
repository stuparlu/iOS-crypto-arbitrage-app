//
//  CrossArbitrageOpportunity+CoreDataClass.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 3.8.23..
//
//

import Foundation
import CoreData

@objc(CrossArbitrageOpportunity)
public class CrossArbitrageOpportunity: NSManagedObject {
    
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var exchangePrices : [BidAskData] = [] { didSet {
            comparePrices()
        }
    }
    
    func comparePrices() {
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
            
            if let highestBid = highestBid, let lowestAsk = lowestAsk {
                history?[1] = ((history?[0]) != nil)
                if highestBid.exchange != lowestAsk.exchange && (Double(highestBid.bidPrice) ?? kCFNumberPositiveInfinity as! Double) > Double(lowestAsk.askPrice) ?? 0 {
                    history?[0] = true
                    
                    if history?[0] == true && history?[1] == false {
                        let history = CrossArbitrageHistory(context: viewContext)
                        history.askPrice = Double(lowestAsk.askPrice) ?? 0
                        history.bidPrice = Double(highestBid.bidPrice) ?? 0
                        history.maxExchange = highestBid.exchange
                        history.minExchange = lowestAsk.exchange
                        history.pairName = lowestAsk.symbol
                        history.timestamp = Date.now
                    }
                } else {
                    history?[0] = false
                }
                do {
                    try viewContext.save()
                } catch {}
            }
        }
    }
}
