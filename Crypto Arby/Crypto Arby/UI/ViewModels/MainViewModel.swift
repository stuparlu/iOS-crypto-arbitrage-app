//
//  MainViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 16.10.23..
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selection = 0
    @Published var unreadNotifications : Int = SettingsManager.shared.getUnreadNotifications()
    @Published var unreadTradeResults : Int = 0
    private let notificationCenter = NotificationCenter.default
    private var observationToken: Any?
    
    var handler: Binding<Int> { Binding(
        get: { self.selection },
        set: { self.selection = $0}
    )}
    
    init() {
        observationToken = notificationCenter.addObserver(forName: Notification.Name(rawValue: StringKeys.configuration.newHistoryNotification), object: nil, queue: nil) { [unowned self] notification in
            self.unreadNotifications += 1
            SettingsManager.shared.setUnreadNotifications(self.unreadNotifications)
        }
    }
    
    deinit {
        notificationCenter.removeObserver(observationToken as Any)
    }
    
    func historyViewed() {
        self.unreadNotifications = 0
        SettingsManager.shared.setUnreadNotifications(0)
    }
    
    func tradesViewed() {
        self.unreadTradeResults = 0
    }
}
