//
//  CircularArbitrageHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.10.23..
//
//

import Foundation
import CoreData


extension CircularArbitrageHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CircularArbitrageHistory> {
        return NSFetchRequest<CircularArbitrageHistory>(entityName: "CircularArbitrageHistory")
    }

    @NSManaged public var exchange: String?
    @NSManaged public var pairs: [String]?
    @NSManaged public var profitPercentage: Double

}
