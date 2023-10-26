//
//  CircularArbitrageOpportunity+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//
//

import Foundation
import CoreData
import UserNotifications


extension CircularArbitrageOpportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CircularArbitrageOpportunity> {
        return NSFetchRequest<CircularArbitrageOpportunity>(entityName: "CircularArbitrageOpportunity")
    }

    @NSManaged public var exchangeName: String?
    @NSManaged public var history: [Bool]?
    @NSManaged public var isActive: Bool
    @NSManaged public var selectedPairs: [String]?
    @NSManaged public var tradingActive: Bool
    
    func sortPrices(_ prices: [BidAskData]) -> [BidAskData] {
        return pairPrices.sorted(by: {(bidask1, bidask2) in
            guard let index1 = selectedPairs?.firstIndex(of: bidask1.symbol),
                  let index2 = selectedPairs?.firstIndex(of: bidask2.symbol) else {
                return false
            }
            return index1 < index2
        })
    }
    
    func sendOpportunityNotificaiton(pairs: [BidAskData], returnPercent: Double) {
        let content = UNMutableNotificationContent()
        let pairString = pairs.map({$0.symbol}).joined(separator: " -> ")
        content.title = StringKeys.arbitrageFound
        content.body = "Exchange: \(exchangeName!.capitalized)\nPairs: \(pairString)\nProfit: \(returnPercent)%"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func comparePrices() {
        if let selectedPairs = selectedPairs, var safeHistory = history {
            if pairPrices.count == selectedPairs.count {
                let startBalance = 100.0
                let tradeSteps = sortPrices(pairPrices)
                let firstTicker = Cryptocurrencies.findPair(by: tradeSteps.first!.symbol)
                let firstSymbol = firstTicker.quoteSymbol
                var output = startBalance
                var ownedCurrency = firstSymbol
                for tradeStep in tradeSteps {
                    let currentTicker = Cryptocurrencies.findPair(by: tradeStep.symbol)
                    let price = Double(tradeStep.askPrice) ?? Double.infinity
                    if ownedCurrency == currentTicker.quoteSymbol {
                        output = output / price
                        ownedCurrency = currentTicker.mainSymbol
                    } else {
                        output = output * price
                        ownedCurrency = currentTicker.quoteSymbol
                    }
                }
                safeHistory[1] = safeHistory[0]
                if ownedCurrency == firstSymbol && output > startBalance {
                    safeHistory[0] = true
                    if safeHistory[0] && !safeHistory[1] {
                        let totalReturn = (((output - startBalance)/startBalance) * 100).rounded(toPlaces: 4)
                        sendOpportunityNotificaiton(pairs: tradeSteps, returnPercent: totalReturn)
                        DatabaseManager.shared.saveCircularHistoryData(exchange: exchangeName!, pairs: tradeSteps.map({$0.symbol}), profitPercentage: totalReturn)
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

extension CircularArbitrageOpportunity : Identifiable {

}

extension CircularArbitrageOpportunity : Tradable {
    func addPrices(price: BidAskData) {
        pairPrices.append(price)
    }
}
