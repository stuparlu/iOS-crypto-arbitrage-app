//
//  CircularArbitrageOpportunity+CoreDataClass.swift
//
//
//  Created by Luka Stupar on 7.10.23..
//
//

import Foundation
import CoreData

@objc(CircularArbitrageOpportunity)
public class CircularArbitrageOpportunity: NSManagedObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var exchangePrices : [BidAskData] = [] { 
        didSet {
            comparePrices()
        }
    }
    
    func comparePrices() {
        if exchangePrices.count == selectedPairs?.count {
            
        }
    }
}
