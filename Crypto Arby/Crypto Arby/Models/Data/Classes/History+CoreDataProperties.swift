//
//  History+CoreDataProperties.swift
//  
//
//  Created by Luka Stupar on 12.10.23..
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

extension History: Identifiable {
    
}
