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
    @Published var history : [CrossArbitrageHistory] = []
    private var cancellable: AnyCancellable?
    
    init() {
        self.history = DatabaseManager.shared.getAllHistory()
        self.cancellable = DatabaseManager.shared.$changes
            .sink { [weak self] _ in
                self?.history = DatabaseManager.shared.getAllHistory()
            }
    }

    func getTimestampString(timestamp: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: timestamp)
    }
}
