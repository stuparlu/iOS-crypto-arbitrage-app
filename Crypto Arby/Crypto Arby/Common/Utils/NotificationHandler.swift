//
//  NotificationHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 28.10.23..
//

import Foundation
import UserNotifications

struct NotificationHandler {
    static func sendCrossOpportunityNotificaiton(pair: String, buyExchange: String, sellExchange: String) {
        let content = UNMutableNotificationContent()
        content.title = StringKeys.displayed.arbitrageFound
        content.body = "Pair \(pair)\nBuy at: \(buyExchange), sell at: \(sellExchange)"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    static func sendCircularOpportunityNotificaiton(exchangeName: String, pairs: [BidAskData], returnPercent: Double) {
        let content = UNMutableNotificationContent()
        let pairString = pairs.map({$0.symbol}).joined(separator: " -> ")
        content.title = StringKeys.displayed.arbitrageFound
        content.body = "Exchange: \(exchangeName.capitalized)\nPairs: \(pairString)\nProfit: \(returnPercent)%"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
