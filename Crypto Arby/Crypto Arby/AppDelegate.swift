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
    var timer = Timer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { allowed, error in
            if allowed {
                
            } else {
                print("Error while requesting push notification permission. Error \(String(describing: error))")
            }
        }
        startTimer()
        return true
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: DefaultConfiguration.scanInterval, repeats: true) { _ in
            self.operationQueue.addOperation(ArbitrqageOperation())
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        timer.invalidate()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
