//
//  DatabaseManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import Foundation
import CoreData

class DatabaseManager: ObservableObject {
    static let shared = DatabaseManager()
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var changes = false
    
    func toggleChanges() {
        changes.toggle()
    }
    
    func saveNewCrossOpportunity(pairName: String, exchanges: [String], tradingActive: Bool) {
        let newOpportunity = CrossArbitrageOpportunity(context: viewContext)
        newOpportunity.isActive = true
        newOpportunity.pairName = pairName
        newOpportunity.selectedExchanges = exchanges
        newOpportunity.tradingActive = tradingActive
        newOpportunity.history = [false, false]
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
    }
    
    func saveNewCircularOpportunity(exchangeName: String, pairs: [String], tradingActive: Bool) {
        let newOpportunity = CircularArbitrageOpportunity(context: viewContext)
        newOpportunity.isActive = true
        newOpportunity.exchangeName = exchangeName
        newOpportunity.selectedPairs = pairs
        newOpportunity.tradingActive = tradingActive
        newOpportunity.history = [false, false]
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
    }

    func deleteCrossOpportunity(item: CrossArbitrageOpportunity) {
        do {
            viewContext.delete(item)
            try viewContext.save()
            toggleChanges()
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    func deleteCircularOpportunity(item: CircularArbitrageOpportunity) {
        do {
            viewContext.delete(item)
            try viewContext.save()
            toggleChanges()
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
    
    func getAllCrossOpportunities() -> [CrossArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CrossArbitrageOpportunity> = NSFetchRequest(entityName: "CrossArbitrageOpportunity")
            var opportunities : [CrossArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
    
    func getAllCircularOpportunities() -> [CircularArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CircularArbitrageOpportunity> = NSFetchRequest(entityName: "CircularArbitrageOpportunity")
            var opportunities : [CircularArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
    
    func saveCircularHistoryData(exchange: String, pairs: [String], profitPercentage: Double) {
        let historyData = CircularArbitrageHistory(context: viewContext)
        historyData.exchange = exchange
        historyData.pairs = pairs
        historyData.profitPercentage = profitPercentage
        historyData.timestamp = Date.now
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
        NotificationCenter.default.post(name: NSNotification.Name(StringKeys.configuration.newHistoryNotification), object: nil)
    }
    
    func saveCrossHistoryData(lowestAsk: BidAskData, highestBid: BidAskData) {
        let historyData = CrossArbitrageHistory(context: viewContext)
        historyData.askPrice = lowestAsk.askPrice
        historyData.bidPrice = highestBid.bidPrice
        historyData.maxExchange = highestBid.exchange
        historyData.minExchange = lowestAsk.exchange
        historyData.pairName = lowestAsk.symbol
        historyData.timestamp = Date.now
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
        NotificationCenter.default.post(name: NSNotification.Name(StringKeys.configuration.newHistoryNotification), object: nil)
    }
    
    func getAllCrossHistory() -> [CrossArbitrageHistory] {
        do {
            let historyRequest : NSFetchRequest<CrossArbitrageHistory> = NSFetchRequest(entityName: "CrossArbitrageHistory")
            var historyElements : [CrossArbitrageHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch cross opportunities: \(error)")
        }
    }
    
    func getAllCircularHistory() -> [CircularArbitrageHistory] {
        do {
            let historyRequest : NSFetchRequest<CircularArbitrageHistory> = NSFetchRequest(entityName: "CircularArbitrageHistory")
            var historyElements : [CircularArbitrageHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch circular opportunities: \(error)")
        }
    }
    
    func saveCrossTradeHistory(success: Bool, message: String, amount: Double, lowestAsk: BidAskData, highestBid: BidAskData, askOrderID: String, bidOrderID: String) {
        let historyData = CrossArbitrageTradeHistory(context: viewContext)
        historyData.timestamp = Date.now
        historyData.success = success
        historyData.message = message
        historyData.symbol = lowestAsk.symbol
        historyData.askExchange = lowestAsk.exchange
        historyData.askAmount = amount
        historyData.askPrice = lowestAsk.askPrice
        historyData.askOrderID = askOrderID
        historyData.bidExchange = highestBid.exchange
        historyData.bidAmount = amount
        historyData.bidPrice = highestBid.bidPrice
        historyData.bidOrderID = bidOrderID
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
        NotificationCenter.default.post(name: NSNotification.Name(StringKeys.configuration.newHistoryNotification), object: nil)
    }
    
    func getAllCrossTradeHistory() -> [CrossArbitrageTradeHistory] {
        do {
            let historyRequest : NSFetchRequest<CrossArbitrageTradeHistory> = NSFetchRequest(entityName: "CrossArbitrageTradeHistory")
            var historyElements : [CrossArbitrageTradeHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch cross opportunities: \(error)")
        }
    }
    
    func getAllCircularTradeHistory() -> [CircularArbitrageTradeHistory] {
        do {
            let historyRequest : NSFetchRequest<CircularArbitrageTradeHistory> = NSFetchRequest(entityName: "CircularArbitrageTradeHistory")
            var historyElements : [CircularArbitrageTradeHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch cross opportunities: \(error)")
        }
    }
    
}
