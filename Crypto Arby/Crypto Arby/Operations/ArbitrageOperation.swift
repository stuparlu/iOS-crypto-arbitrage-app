//
//  arbitrageOperation.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import Foundation
import CoreData
import SwiftUI

final class ArbitrageOperation {
    static func refreshCrossOpportunities(_ opportunities: [CrossArbitrageOpportunity]) async {
        for opportunity in opportunities {
            if !opportunity.isActive {
                continue
            }
            guard let ticker = opportunity.pairName, let exchanges = opportunity.selectedExchanges else {
                continue
            }
            var opportunityPrices: [BidAskData] = []
            for exchange in exchanges {
                let prices = await Exchanges.mapper.getRequestHandler(for: exchange).getBidAskData(for: ticker)
                if let prices = prices {
                    opportunityPrices.append(prices)
                }
                if opportunityPrices.count >= 2 {
                    await PriceComparator.compareCrossPrices(for: opportunity, exchangePrices: opportunityPrices)
                }
            }
        }
    }
    
    static func refreshCircularOpportunities(_ opportunities: [CircularArbitrageOpportunity]) async {
        for opportunity in opportunities {
            if !opportunity.isActive {
                continue
            }
            guard let exchange = opportunity.exchangeName, let pairs = opportunity.selectedPairs else {
                continue
            }
            var opportunityPrices: [BidAskData] = []
            for pair in pairs {
                let ticker = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: pair), at: exchange)
                let prices = await Exchanges.mapper.getRequestHandler(for: exchange).getBidAskData(for: ticker)
                if let prices = prices {
                    opportunityPrices.append(prices)
                }
            }
            if opportunityPrices.count == pairs.count {
                await PriceComparator.compareCircularPrices(for: opportunity, exchangePrices: opportunityPrices)
            }
        }
    }
    
    @Sendable
    static func execute() async {
        DispatchQueue.main.async {
            print("work \(Date.now)")
        }
        await refreshCrossOpportunities(DatabaseManager.shared.getAllCrossOpportunities())
        await refreshCircularOpportunities(DatabaseManager.shared.getAllCircularOpportunities())
    }
}
