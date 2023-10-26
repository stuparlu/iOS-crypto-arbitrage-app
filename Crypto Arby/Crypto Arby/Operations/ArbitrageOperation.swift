//
//  arbitrageOperation.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import Foundation
import CoreData
import SwiftUI

final class ArbitrqageOperation: Operation {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    private let viewContext = PersistenceController.shared.container.viewContext
    
    func getCrossOpportunities() -> [CrossArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CrossArbitrageOpportunity> = NSFetchRequest(entityName: "CrossArbitrageOpportunity")
            var opportunities : [CrossArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            print("Failed to fetch cross opportunities: \(error)")
            return []
        }
    }
    
    func getCircularOpportunities() -> [CircularArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CircularArbitrageOpportunity> = NSFetchRequest(entityName: "CircularArbitrageOpportunity")
            var opportunities : [CircularArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            print("Failed to fetch circular opportunities: \(error)")
            return []
        }
    }
    
    func refreshCrossOpportunities(_ opportunities: [CrossArbitrageOpportunity]) {
        for opportunity in opportunities {
            if !opportunity.isActive {
                continue
            }
            guard let ticker = opportunity.pairName, let exchanges = opportunity.selectedExchanges else {
                continue
            }
            for exchange in exchanges {
                PricesModel.getPricesForTickerAtExchange(exchange: exchange, ticker: ticker, delegate: opportunity)
            }
        }
    }
    
    func refreshCircularOpportunities(_ opportunities: [CircularArbitrageOpportunity]) {
        for opportunity in opportunities {
            if !opportunity.isActive {
                continue
            }
            guard let exchange = opportunity.exchangeName, let pairs = opportunity.selectedPairs else {
                continue
            }
            for pair in pairs {
                let ticker = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: pair), at: exchange) 
                PricesModel.getPricesForTickerAtExchange(exchange: exchange, ticker: ticker, delegate: opportunity)
            }
        }
    }
    
    override func main() {
        refreshCrossOpportunities(getCrossOpportunities())
        refreshCircularOpportunities(getCircularOpportunities())
    }
}
