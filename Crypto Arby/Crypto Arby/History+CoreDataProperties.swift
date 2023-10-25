//
//  History+CoreDataProperties.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.10.23..
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var timestamp: Date?

}

extension History : Identifiable {

}
