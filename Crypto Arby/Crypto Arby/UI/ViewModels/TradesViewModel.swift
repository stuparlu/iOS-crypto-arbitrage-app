//
//  TradesViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.10.23..
//

import Foundation
import CoreData
import Combine



class TradesViewModel: ObservableObject {
    @Published var trades: [TradeHistory] = []
    private var cancellable: AnyCancellable?

    init() {
        self.loadTrades()
        self.cancellable = DatabaseManager.shared.$changes.sink { [weak self] _ in
            self?.loadTrades()
        }
    }
    
    func loadTrades() {
        let crossHistory = DatabaseManager.shared.getAllCrossTradeHistory()
        let circularHistory = DatabaseManager.shared.getAllCircularTradeHistory()
        trades = (crossHistory + circularHistory).sorted(by: {
            if let time0 = $0.timestamp, let time1 = $1.timestamp {
                return time0 > time1
            }
            return false
        })
    }
    
    func getTimestampString(timestamp: Date) -> String {
        return DateHandler.dateToString(timestamp)
    }
}
