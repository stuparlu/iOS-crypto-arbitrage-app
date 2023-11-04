//
//  NewCircularArbitrageModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct NewCircularArbitrageModel {
    var exchangeSelected = false
    var selectedExchange = StringKeys.placeholders.emptyString
    var searchText = StringKeys.placeholders.emptyString
    var selectedPairs: [CurrencyPair] = []
    var nextPairs: [CurrencyPair] = []
    var saveAlertShown = false
    var tradingEnabled: Bool = false
    var autotradeAvailable: Bool = false
    var startPair: CurrencyPair? = nil
    let exchangeList = Exchanges.names.allNames
}
