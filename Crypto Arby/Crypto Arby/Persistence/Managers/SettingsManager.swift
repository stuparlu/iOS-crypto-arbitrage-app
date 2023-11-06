//
//  SettingsManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 16.10.23..
//

import Foundation

struct SettingsManager {
    static let shared = SettingsManager()
    
    func getMonitoredCurrency() -> String {
        UserDefaults.standard.string(forKey:StringKeys.configuration.monitoredCurrency) ?? DefaultConfiguration.monitoredCurrency
    }
    
    func setMonitoredCurrency(_ currency: String) {
        UserDefaults.standard.set(currency, forKey: StringKeys.configuration.monitoredCurrency)
    }
    
    func getUnreadNotifications() -> Int {
        UserDefaults.standard.integer(forKey:StringKeys.configuration.unreadNotifications) 
    }
    
    func setUnreadNotifications(_ notifications: Int) {
        UserDefaults.standard.set(notifications, forKey: StringKeys.configuration.unreadNotifications)
    }
    
    func getUnreadTradeNotifications() -> Int {
        UserDefaults.standard.integer(forKey:StringKeys.configuration.unreadTradeNotifications)
    }
    
    func setUnreadTradeNotifications(_ notifications: Int) {
        UserDefaults.standard.set(notifications, forKey: StringKeys.configuration.unreadTradeNotifications)
    }
    
    func getPercentageThreshold() -> Double {
        UserDefaults.standard.double(forKey:StringKeys.configuration.percentageThreshold)
    }
    
    func setPercentageThreshold(_ threshold: Double) {
        UserDefaults.standard.set(threshold, forKey: StringKeys.configuration.percentageThreshold)
    }
}
