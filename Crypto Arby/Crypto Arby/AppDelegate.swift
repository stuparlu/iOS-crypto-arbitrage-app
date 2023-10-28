//
//  AppDelegate.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.9.23..
//

import Foundation
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    let databaseManager = DatabaseManager.shared
    let operationQueue = OperationQueue()
    var arbitrageRunning: Bool = false
    let arbitrageQueue = DispatchQueue(label: "com.lukastupar.CryptoArby.arbitrageQueue", qos: .background)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed {
                
            } else {
                print("Error while requesting push notification permission. Error \(String(describing: error))")
            }
        }
        scheduleScanner()
        return true
    }
    
    func scheduleScanner() {
        guard !arbitrageRunning else {
            return
        }
        arbitrageRunning = true
        let interval: TimeInterval = TimeInterval(DefaultConfiguration.scanInterval)
        arbitrageQueue.asyncAfter(deadline: .now() + interval) { [weak self] in
            Task {
                await ArbitrageOperation.execute()
                self?.arbitrageRunning = false
                self?.scheduleScanner()
            }
        }
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        arbitrageQueue.suspend()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
