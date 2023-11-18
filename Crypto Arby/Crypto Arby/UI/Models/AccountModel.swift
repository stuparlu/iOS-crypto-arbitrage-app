//
//  AccountModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct AccountModel {
    var percentageThreshold = String(SettingsManager.shared.getPercentageThreshold())
    var showingManageExchanges = false
    var showingManageWallets = false
}
