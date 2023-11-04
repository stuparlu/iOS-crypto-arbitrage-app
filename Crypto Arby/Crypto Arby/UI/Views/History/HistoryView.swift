//
//  HistoryView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//

import SwiftUI

struct HistoryView: View {
    let viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.getHistory()) { item in
                    if String(describing: type(of: item.self)) == String(describing: CrossArbitrageHistory.self) {
                        AnyView(CrossArbitrageHistoryCellView(dataModel: item as! CrossArbitrageHistory))
                    } else if String(describing: type(of: item.self)) == String(describing: CircularArbitrageHistory.self) {
                        AnyView(CircularArbitrageHistoryCellView(dataModel: item as! CircularArbitrageHistory))
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
            }
            .navigationTitle(StringKeys.displayed.history)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabView {
        HistoryView()
            .tabItem {
                Image(systemName: Symbols.opportunity_history_icon)
                Text(StringKeys.displayed.history)
            }
    }
}
