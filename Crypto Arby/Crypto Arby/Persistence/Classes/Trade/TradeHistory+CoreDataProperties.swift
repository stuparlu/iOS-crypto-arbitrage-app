//
//  TradeHistory+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.10.23..
//
//

import Foundation
import CoreData


extension TradeHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TradeHistory> {
        return NSFetchRequest<TradeHistory>(entityName: "TradeHistory")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var success: Bool
    @NSManaged public var message: String?

}

extension TradeHistory : Identifiable {

}
