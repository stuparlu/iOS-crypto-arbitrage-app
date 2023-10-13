//
//  DateHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.10.23..
//

import Foundation

struct DateHandler {
    static func dateToString(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter.string(from: date ?? Date.distantPast)
    }
}
