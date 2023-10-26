//
//  CircularArbitrageOpportunity+CoreDataClass.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//
//

import Foundation
import CoreData

@objc(CircularArbitrageOpportunity)
public class CircularArbitrageOpportunity: NSManagedObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var pairPrices : [BidAskData] = [] {
        didSet {
            comparePrices()
        }
    }
}
