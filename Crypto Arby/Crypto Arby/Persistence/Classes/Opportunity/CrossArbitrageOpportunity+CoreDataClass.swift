//
//  CrossArbitrageOpportunity+CoreDataClass.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//
//

import Foundation
import CoreData

@objc(CrossArbitrageOpportunity)
public class CrossArbitrageOpportunity: NSManagedObject {
    let viewContext = PersistenceController.shared.container.viewContext
}
