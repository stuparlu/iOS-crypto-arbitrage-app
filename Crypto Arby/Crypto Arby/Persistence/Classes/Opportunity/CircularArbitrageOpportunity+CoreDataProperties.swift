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
}

extension CircularArbitrageOpportunity : Identifiable {}
