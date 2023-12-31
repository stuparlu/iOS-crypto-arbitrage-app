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
        navigationViewAppearance.backgroundColor = UIColor(ThemeManager.backgroundColor)
        UINavigationBar.appearance().standardAppearance = navigationViewAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationViewAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(ThemeManager.backgroundColor)
        tabBarAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor(ThemeManager.accentColor)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(ThemeManager.backgroundColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(ThemeManager.accentColor)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(ThemeManager.backgroundColor)], for: .normal)
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        
        UIView.appearance().tintColor = UIColor(ThemeManager.accentColor)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
