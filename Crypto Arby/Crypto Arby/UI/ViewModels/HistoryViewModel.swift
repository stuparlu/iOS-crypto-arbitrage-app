//
//  HistoryViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//

import Foundation
import CoreData
import Combine

class HistoryViewModel: ObservableObject {
    @Published var model = HistoryModel()
    private var cancellable: AnyCancellable?
    
    init() {
        self.loadHistory()
        self.cancellable = DatabaseManager.shared.$changes.sink { [weak self] _ in
            self?.loadHistory()
        }
    }
    
    func loadHistory() {
        let crossHistory = DatabaseManager.shared.getAllCrossHistory()
        let circularHistory = DatabaseManager.shared.getAllCircularHistory()
        model.history = (crossHistory + circularHistory).sorted(by: {
            if let time0 = $0.timestamp, let time1 = $1.timestamp {
                return time0 > time1
            }
            return false
        })
    }
    
    func getHistory() -> [History] {
        return model.history
    }
    
    func getTimestampString(timestamp: Date) -> String {
        return DateHandler.dateToString(timestamp)
    }
}
