//
//  CircularArbitrageOpportunity+CoreDataProperties.swift
//
//
//  Created by Luka Stupar on 7.10.23..
//
//

import Foundation
import CoreData


extension CircularArbitrageOpportunity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CircularArbitrageOpportunity> {
        return NSFetchRequest<CircularArbitrageOpportunity>(entityName: "CircularArbitrageOpportunity")
    }
    
    @NSManaged public var history: [Bool]?
    @NSManaged public var isActive: Bool
    @NSManaged public var exchangeName: String?
    @NSManaged public var selectedPairs: [String]?
    
}

extension CircularArbitrageOpportunity : Identifiable {
    
}

extension CircularArbitrageOpportunity : Tradable {
    func addPrices(price: BidAskData) {
        exchangePrices.append(price)
    }
}
