//
//  arbitrageOperation.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import Foundation
import CoreData

final class ArbitrqageOperation: Operation {
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    override func main() {
        do {
            let opportunitiesRequest : NSFetchRequest<CrossArbitrageOpportunity> = NSFetchRequest(entityName: "CrossArbitrageOpportunity")
            var opportunities : [CrossArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            for opportunity in opportunities {
                guard let ticker = opportunity.pairName else {
                    continue
                }
                guard let exchanges = opportunity.selectedExchanges else {
                    continue
                }
                for exchange in exchanges {
                    PricesModel.getPricesForTickerAtExchange(exchange: exchange, ticker: ticker, delegate: opportunity)
                }
            }
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
}
