//
//  HistoryViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//

import Foundation
import CoreData

class HistoryViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    @Published var history : [CrossArbitrageHistory] = []

    init() {
        history = getAllHistory()
    }
    
    func getAllHistory() -> [CrossArbitrageHistory] {
        do {
            let historyRequest : NSFetchRequest<CrossArbitrageHistory> = NSFetchRequest(entityName: "CrossArbitrageHistory")
            var historyElements : [CrossArbitrageHistory] = []
            historyElements = try viewContext.fetch(historyRequest)
            return historyElements
        } catch {
            fatalError("Failed to fetch opportunities: \(error)")
        }
    }
    
}
