//
//  CircularArbitrageTradeHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.10.23..
//
//

import Foundation
import CoreData


extension CircularArbitrageTradeHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CircularArbitrageTradeHistory> {
        return NSFetchRequest<CircularArbitrageTradeHistory>(entityName: "CircularArbitrageTradeHistory")
    }

    @NSManaged public var exchange: String?

}
