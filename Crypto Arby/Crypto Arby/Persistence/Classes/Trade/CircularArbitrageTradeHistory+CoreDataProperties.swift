//
//  CircularArbitrageTradeHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 6.11.23..
//
//

import Foundation
import CoreData


extension CircularArbitrageTradeHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CircularArbitrageTradeHistory> {
        return NSFetchRequest<CircularArbitrageTradeHistory>(entityName: "CircularArbitrageTradeHistory")
    }

    @NSManaged public var exchange: String?
    @NSManaged public var orderIDs: [String]?
    @NSManaged public var pairs: [String]?
    @NSManaged public var prices: [Double]?

}
