//
//  MainView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.7.23..
//

import SwiftUI
import BackgroundTasks

struct MainView: View {
    var body: some View {
        VStack {
            TabView {
                PricesView()
                    .tabItem {
                        Image(systemName: Symbols.price_history_icon)
                        Text(StringKeys.prices)
                    }
                OpportunitiesView()
                    .tabItem {
                        Image(systemName:Symbols.opportunities_icon)
                        Text(StringKeys.opportunities)
                    }
                
                HistoryView()
                    .tabItem {
                        Image(systemName: Symbols.opportunity_history_icon)
                        Text(StringKeys.history)
                    }
                
                Text("Account")
                    .tabItem {
                        Image(systemName: Symbols.user_account_icon)
                        Text(StringKeys.account)
                    }
            }
        }
        .onAppear() {
            //            This should be tested on a device when available
            //            self.registerBGTaskScheduler()
            //            self.scheduleAppRefresh()
            let operation = ArbitrqageOperation()
            let operationQueue = OperationQueue()
            operationQueue.addOperation(operation)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
