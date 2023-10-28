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
    
}

extension CrossArbitrageOpportunity : Identifiable {}
