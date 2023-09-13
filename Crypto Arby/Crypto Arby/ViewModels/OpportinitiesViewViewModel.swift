//
//  OpportinitiesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import Foundation
import CoreData


class OpportinitiesViewViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var opportunities : [CrossArbitrageOpportunity] = []

    init() {
        opportunities = getAllOpportunities()
    }
    
    func getAllOpportunities() -> [CrossArbitrageOpportunity] {
        do {
            let opportunitiesRequest : NSFetchRequest<CrossArbitrageOpportunity> = NSFetchRequest(entityName: "CrossArbitrageOpportunity")
            var opportunities : [CrossArbitrageOpportunity] = []
            opportunities = try viewContext.fetch(opportunitiesRequest)
            return opportunities
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
}
