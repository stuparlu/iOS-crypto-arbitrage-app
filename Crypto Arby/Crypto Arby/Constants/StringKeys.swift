//
//  StringKeys.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 18.7.23..
//

import Foundation

struct StringKeys {
    static let opportunities = "Opportunities"
    static let prices = "Prices"
    static let history = "History"
    static let account = "Account"
    static let exchange = "Exchange"
    static let highest_bid = "Highest Bid"
    static let lowestAsk = "Lowest Ask"
    static let cross_arbitrage = "Cross Exchange Arbitrage"
    static let new_cross_arbitrage = "New Cross Arbitrage Opportunity"
    static let crossOpportunity = "Cross Arbitrage:"
    static let circularOpportunity = "Circular Arbitrage:"
    static let new_circular_arbitrage = "New Circular Arbitrage Opportunity"
    static let circular_arbitrage = "Circular Arbitrage"
    static let search = "Search"
    static let search_pairs = "Search pairs"
    static let searchPairsToAdd = "Search pairs to add"
    static let search_exchanges = "Search exchanges"
    static let pair_selected = "Pair: "
    static let saveOpportunity = "Save Opportunity"
    static let select_exchanges = "Select exchanges to monitor:"
    static let coin_ticker = "coin_ticker"
    static let coin_name = "coin_name"
    static let ticker_placeholder = "[TICKER]"
    static let empty_string = ""
    static let ok = "OK"
    static let login = "Log in"
    static let register = "Register"
    static let email = "E-mail"
    static let password = "Password"
    static let arbitrageFound = "Arbitrage opportunity found"
    static let invalidEmailTitle = "Invalid e-mail"
    static let invalidEmailMessage = "E-mail address is invalid."
    static let invalidPasswordTitle = "Invalid Password"
    static let invalidPasswordMessage = "You have to type a password that is at least 6 characters long, contains at least one uppercase, lowercase and numerical and special character with no whitespaces."
    static let registrationFailedTitle = "Registration failed"
    static let registrationFailedMessage = "Please check your credential and try again. If you have already registered, please select log in."
    static let loginFailedTitle = "Log in failed"
    static let loginFailedMessage = "Please check your credential and try again."
    static let logout = "Log out"
    static let selectedPairs = "Selected pairs"
    static let selectPairsToAdd = "Select pairs to add"
    static let clearLast = "Clear last"
    static let circularSaveFailedTitle = "Cannot Save opportunity"
    static let circularSaveFailedMessage = "The opportunity configuration is invalid. It has to contain at least 3 pairs. First and last pair have to have same quote symbol. Each non-last pair has to end with the beginning of the previous one."
    static let exchanges = "Exchanges:"
    static let price = "Price:"
    static let path = "Path:"
    static let profit = "Profit:"
    static let time = "Time:"
    static let signPercent = "%"
    static let apiKey = "API Key"
    static let apiSecret = "API Secret"
    static let manageExchange = "Manage Exchange"
    static let manageExchanges = "Manage Exchanges"
    static let saveConfiguration = "Save configuration"
    static let clearConfiguration = "Delete"
    static let clearAllKeys = "Clear all keys"
    static let autoTradePrompt = "Automatic trade execution"
    
    struct errors {
        static let generic_error = "Error"
    }
    struct alerts {
        static let select_exchanges = "You need to select a pair and at least two exchanges."
    }
    
    struct configuration {
        static let monitoredCurrency = "monitoredCurrency"
        static let newHistoryNotification = "newHistoryNotification"
        static let unreadNotifications = "unreadNotifications"
    }
}
