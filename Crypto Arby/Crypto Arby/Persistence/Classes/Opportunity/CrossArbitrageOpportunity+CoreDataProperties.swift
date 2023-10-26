//
//  CrossArbitrageOpportunity+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//
//

import Foundation
import CoreData
import UserNotifications

extension CrossArbitrageOpportunity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrossArbitrageOpportunity> {
        return NSFetchRequest<CrossArbitrageOpportunity>(entityName: "CrossArbitrageOpportunity")
    }
    
    @NSManaged public var history: [Bool]?
    @NSManaged public var isActive: Bool
    @NSManaged public var pairName: String?
    @NSManaged public var selectedExchanges: [String]?
    @NSManaged public var tradingActive: Bool
    
    func sendCrossOpportunityNotificaiton(pair: String, buyExchange: String, sellExchange: String) {
        let content = UNMutableNotificationContent()
        content.title = StringKeys.arbitrageFound
        content.body = "Pair \(pair)\nBuy at: \(buyExchange), sell at: \(sellExchange)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
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
            
            if let highestBid = highestBid, let lowestAsk = lowestAsk, var safeHistory = history {
                safeHistory[1] = safeHistory[0]
                if highestBid.exchange != lowestAsk.exchange && (Double(highestBid.bidPrice) ?? kCFNumberPositiveInfinity as! Double) < Double(lowestAsk.askPrice) ?? 0 {
                    safeHistory[0] = true
                    if safeHistory[0] && !safeHistory[1] {
                        sendCrossOpportunityNotificaiton(pair: lowestAsk.symbol, buyExchange: lowestAsk.exchange.capitalized, sellExchange: highestBid.exchange.capitalized)
                        DatabaseManager.shared.saveCrossHistoryData(lowestAsk: lowestAsk, highestBid: highestBid)
                        // If enabled execution
                        CrossArbitrageExcutor().executeTrades(bid: highestBid, ask: lowestAsk)
                    }
                } else {
                    safeHistory[0] = false
                }
                self.history = safeHistory
                do {
                    try viewContext.save()
                } catch {}
            }
        }
    }
}

extension CrossArbitrageOpportunity : Identifiable {
    
}

extension CrossArbitrageOpportunity : Tradable {
    func addPrices(price: BidAskData) {
        exchangePrices.append(price)
    }
}
