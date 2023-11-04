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
                        Text(StringKeys.displayed.prices)
                    }
                    .tag(0)
                OpportunitiesView()
                    .tabItem {
                        Image(systemName:Symbols.opportunities_icon)
                        Text(StringKeys.displayed.opportunities)
                    }
                    .tag(1)
                
                HistoryView()
                    .tabItem {
                        Image(systemName: Symbols.opportunity_history_icon)
                        Text(StringKeys.displayed.history)

                    }
                    .badge(viewModel.model.unreadNotifications)
                    .tag(2)
                
                TradesView()
                    .tabItem {
                        Image(systemName: Symbols.opportunity_trade_icon)
                        Text(StringKeys.displayed.trades)

                    }
                    .badge(viewModel.model.unreadTradeResults)
                    .tag(3)
                
                AccountView()
                    .tabItem {
                        Image(systemName: Symbols.user_account_icon)
                        Text(StringKeys.displayed.account)
                    }
                    .tag(4)
            }
        }
        .onChange(of: viewModel.model.selection) { newTab in
            if newTab == 2 {
                viewModel.historyViewed()
            } else if newTab == 3 {
                viewModel.tradesViewed()
            }
        }
    }
    
    func registerBGTaskScheduler() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.lukastupar.Crypto-Arby.Refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.lukastupar.Crypto-Arby.Refresh")
        request.earliestBeginDate = Calendar.current.date(byAdding: .second, value: Int(DefaultConfiguration.scanInterval), to: Date())
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
