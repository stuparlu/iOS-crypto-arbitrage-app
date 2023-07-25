//
//  MainView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.7.23..
//

import SwiftUI

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
                
                Text("History")
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
