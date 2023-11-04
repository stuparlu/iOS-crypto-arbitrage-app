//
//  AccountViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published var model = AccountModel()
    
    func savePercentageThreshold() {
        SettingsManager.shared.setPercentageThreshold(Double(model.percentageThreshold)!)
    }
    
    func send() {
        Task {
            do {
                let data = await HivePoolsRequestHandler.getBalance(symbol: "SWAP.HIVE")
                print(data)
            } catch {}
        }
    }
}

