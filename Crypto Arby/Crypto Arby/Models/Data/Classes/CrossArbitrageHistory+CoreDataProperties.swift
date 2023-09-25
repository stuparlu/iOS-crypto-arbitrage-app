//
//  CrossArbitrageHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//
//

import Foundation
import CoreData


extension CrossArbitrageHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrossArbitrageHistory> {
        return NSFetchRequest<CrossArbitrageHistory>(entityName: "CrossArbitrageHistory")
    }

    @NSManaged public var pairName: String?
    @NSManaged public var minExchange: String?
    @NSManaged public var maxExchange: String?
    @NSManaged public var bidPrice: Double
    @NSManaged public var askPrice: Double
    @NSManaged public var timestamp: Date?

}

extension CrossArbitrageHistory : Identifiable {

}
