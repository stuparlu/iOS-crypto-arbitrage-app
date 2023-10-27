//
//  CrossArbitrageTradeHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.10.23..
//
//

import Foundation
import CoreData


extension CrossArbitrageTradeHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrossArbitrageTradeHistory> {
        return NSFetchRequest<CrossArbitrageTradeHistory>(entityName: "CrossArbitrageTradeHistory")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var bidExchange: String?
    @NSManaged public var askExchange: String?
    @NSManaged public var bidPrice: Double
    @NSManaged public var bidAmount: Double
    @NSManaged public var askPrice: Double
    @NSManaged public var askAmount: Double
    @NSManaged public var bidOrderID: String?
    @NSManaged public var askOrderID: String?

}
