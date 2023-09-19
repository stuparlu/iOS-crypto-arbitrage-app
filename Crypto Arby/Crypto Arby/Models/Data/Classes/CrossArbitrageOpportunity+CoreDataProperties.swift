//
//  CrossArbitrageOpportunity+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//
//

import Foundation
import CoreData


extension CrossArbitrageOpportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrossArbitrageOpportunity> {
        return NSFetchRequest<CrossArbitrageOpportunity>(entityName: "CrossArbitrageOpportunity")
    }

    @NSManaged public var history: [Bool]?
    @NSManaged public var pairName: String?
    @NSManaged public var selectedExchanges: [String]?
    @NSManaged public var isActive: Bool
    
}

extension CrossArbitrageOpportunity : Identifiable {

}

extension CrossArbitrageOpportunity : Tradable {
    func addPrices(price: BidAskData) {
        exchangePrices.append(price)
    }
}
