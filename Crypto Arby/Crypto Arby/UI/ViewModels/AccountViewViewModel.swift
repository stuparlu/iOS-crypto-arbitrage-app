//
//  AccountViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation

class AccountViewViewModel: ObservableObject {
    @Published var percentageThreshold = String(SettingsManager.shared.getPercentageThreshold())
    
    func savePercentageThreshold() {
        SettingsManager.shared.setPercentageThreshold(Double(percentageThreshold)!)
    }
    
    func send() {
        Task {
            do {
              let data = try await BinanceRequestHandler.submitMarketOrder(symbol: "BTCUSDT", side: .buy, amount: 0.02)
                print(data)
            }
        }
    }
}
