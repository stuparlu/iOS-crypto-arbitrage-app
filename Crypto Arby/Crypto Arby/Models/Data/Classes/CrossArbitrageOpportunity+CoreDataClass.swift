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
                if highestBid.exchange != lowestAsk.exchange && (Double(highestBid.bidPrice) ?? kCFNumberPositiveInfinity as! Double) < Double(lowestAsk.askPrice) ?? 0 {
                    print("ARBITRAGE!!!!!!!!!!!!!!!!!")
                    print(highestBid)
                    print(lowestAsk)
                }
            }
        }
    }
}
