//
//  CrossArbitrageOpportunity+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 3.8.23..
//
//

import Foundation
import CoreData


extension CrossArbitrageOpportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrossArbitrageOpportunity> {
        return NSFetchRequest<CrossArbitrageOpportunity>(entityName: "CrossArbitrageOpportunity")
    }

    @NSManaged public var pairName: String?
    @NSManaged public var selectedExchanges: [String]?
    @NSManaged public var history: [Bool]?

}

extension CrossArbitrageOpportunity : Identifiable {

}
