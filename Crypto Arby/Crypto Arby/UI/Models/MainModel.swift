//
//  MainModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct MainModel {
    var selection = 0
    var unreadNotifications : Int = SettingsManager.shared.getUnreadNotifications()
    var unreadTradeResults : Int = SettingsManager.shared.getUnreadTradeNotifications()
}
