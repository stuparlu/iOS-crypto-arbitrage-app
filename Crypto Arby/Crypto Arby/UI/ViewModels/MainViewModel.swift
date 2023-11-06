//
//  MainViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 16.10.23..
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var model = MainModel()
    private let notificationCenter = NotificationCenter.default
    private var observationTokenHistory: Any?
    private var observationTokenTrades: Any?
    
    var handler: Binding<Int> { Binding(
        get: { self.model.selection },
        set: { self.model.selection = $0}
    )}
    
    init() {
        observationTokenHistory = notificationCenter.addObserver(forName: Notification.Name(rawValue: StringKeys.configuration.newHistoryNotification), object: nil, queue: nil) { [unowned self] notification in
            self.model.unreadNotifications += 1
            SettingsManager.shared.setUnreadNotifications(self.model.unreadNotifications)
        }
        observationTokenTrades = notificationCenter.addObserver(forName: Notification.Name(rawValue: StringKeys.configuration.newTradeHistoryNotification), object: nil, queue: nil) { [unowned self] notification in
            self.model.unreadTradeResults += 1
            SettingsManager.shared.setUnreadTradeNotifications(self.model.unreadTradeResults)
        }
    }
    
    deinit {
        notificationCenter.removeObserver(observationTokenHistory as Any)
        notificationCenter.removeObserver(observationTokenTrades as Any)
    }
    
    func historyViewed() {
        self.model.unreadNotifications = 0
        SettingsManager.shared.setUnreadNotifications(0)
    }
    
    func tradesViewed() {
        self.model.unreadTradeResults = 0
    }
}
