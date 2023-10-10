//
//  Crypto_ArbyApp.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.7.23..
//

import SwiftUI
import CoreData

@main
struct Crypto_ArbyApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    let persistenceController = PersistenceController.shared
    
    init() {
        let navigationViewAppearance = UINavigationBarAppearance()
        navigationViewAppearance.backgroundColor = UIColor(named: ThemeManager.backgroundColor)
        UINavigationBar.appearance().standardAppearance = navigationViewAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationViewAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: ThemeManager.backgroundColor)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: ThemeManager.backgroundColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.accentColor)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(ThemeManager.backgroundColor))], for: .normal)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
