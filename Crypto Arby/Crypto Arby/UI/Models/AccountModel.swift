//
//  AccountModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

class AccountModel: ObservableObject {
    @Published var percentageThreshold = String(SettingsManager.shared.getPercentageThreshold())
    @Published var showingManageExchanges = false
    @Published var showingManageWallets = false
}
