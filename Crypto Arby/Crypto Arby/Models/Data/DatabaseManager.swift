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
    
    func saveNewCrossOpportunity(pairName: String, exchanges: [String]) {
        let newOpportunity = CrossArbitrageOpportunity(context: viewContext)
        newOpportunity.isActive = true
        newOpportunity.pairName = pairName
        newOpportunity.selectedExchanges = exchanges
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
    
    func getAllOpportunities() -> [CrossArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CrossArbitrageOpportunity> = NSFetchRequest(entityName: "CrossArbitrageOpportunity")
            var opportunities : [CrossArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
    
    func saveHistoryData(lowestAsk: BidAskData, highestBid: BidAskData) {
        let historyData = CrossArbitrageHistory(context: viewContext)
        historyData.askPrice = Double(lowestAsk.askPrice) ?? 0
        historyData.bidPrice = Double(highestBid.bidPrice) ?? 0
        historyData.maxExchange = highestBid.exchange
        historyData.minExchange = lowestAsk.exchange
        historyData.pairName = lowestAsk.symbol
        historyData.timestamp = Date.now
        do {
            try viewContext.save()
        } catch {}
        toggleChanges()
    }
    
    func getAllHistory() -> [CrossArbitrageHistory] {
        do {
            let historyRequest : NSFetchRequest<CrossArbitrageHistory> = NSFetchRequest(entityName: "CrossArbitrageHistory")
            var historyElements : [CrossArbitrageHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
}
