//
//  MainView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.7.23..
//

import SwiftUI
import BackgroundTasks

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            TabView(selection: viewModel.handler){
                PricesView()
                    .tabItem {
                        Image(systemName: Symbols.price_history_icon)
                        Text(StringKeys.prices)
                    }
                    .tag(0)
                OpportunitiesView()
                    .tabItem {
                        Image(systemName:Symbols.opportunities_icon)
                        Text(StringKeys.opportunities)
                    }
                    .tag(1)
                
                HistoryView()
                    .tabItem {
                        Image(systemName: Symbols.opportunity_history_icon)
                        Text(StringKeys.history)

                    }
                    .badge(viewModel.unreadNotifications)
                    .tag(2)
                
                AccountView()
                    .tabItem {
                        Image(systemName: Symbols.user_account_icon)
                        Text(StringKeys.account)
                    }
                    .tag(3)
            }
        }
        .onChange(of: viewModel.selection) { newTab in
            if newTab == 2 {
                viewModel.historyViewed()
            }
        }
        .onAppear() {
            //            This should be tested on a device when available
            //            self.registerBGTaskScheduler()
            //            self.scheduleAppRefresh()
            //            appDelegate.operationQueue.addOperation(ArbitrqageOperation())
        }
    }
    
    func registerBGTaskScheduler() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.lukastupar.Crypto-Arby.Refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.lukastupar.Crypto-Arby.Refresh")
        request.earliestBeginDate = Calendar.current.date(byAdding: .second, value: 30, to: Date())
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
    }
}

#Preview {
    MainView()
}
