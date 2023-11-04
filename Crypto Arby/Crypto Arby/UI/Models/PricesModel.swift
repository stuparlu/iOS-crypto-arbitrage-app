//
//  PricesModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct PricesModel {
    var selectedMenuOptionText = SettingsManager.shared.getMonitoredCurrency()
    var exchangePrices: [BidAskData] = []
    var isNavigationViewHidden = true
    var searchText = StringKeys.placeholders.emptyString
}

