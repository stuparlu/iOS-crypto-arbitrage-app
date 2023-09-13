//
//  TriangularArbitrageOpportunity+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//
//

import Foundation
import CoreData


extension TriangularArbitrageOpportunity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TriangularArbitrageOpportunity> {
        return NSFetchRequest<TriangularArbitrageOpportunity>(entityName: "TriangularArbitrageOpportunity")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var history: [Bool]?
    @NSManaged public var exchange: String?
    @NSManaged public var selectedPairs: [String]?

}

extension TriangularArbitrageOpportunity : Identifiable {

}
