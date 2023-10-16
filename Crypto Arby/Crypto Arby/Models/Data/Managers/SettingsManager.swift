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
}
