//
//  NewCrossArbitrageModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct NewCrossArbitrageModel {
    var searchText = StringKeys.placeholders.emptyString
    var selectedPair = StringKeys.placeholders.emptyString
    var pairSelected = false
    var selectedExchanges: [String] = []
    var showAlert = false
    var shouldDismissView: Bool = false
    var tradingEnabled: Bool = false
    var autotradeAvailable: Bool = false
}
