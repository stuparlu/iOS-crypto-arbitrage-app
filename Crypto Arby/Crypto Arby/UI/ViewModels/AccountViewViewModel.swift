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
                let data = await HivePoolsRequestHandler.getBidAskData(for: "POBSWAP.HIVE")
                print(data)
            } catch {}
        }
    }
}

