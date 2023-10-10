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
                List(viewModel.history) { item in
                    String(describing: item.self) == String(describing: CrossArbitrageHistory.self) ? AnyView(CrossArbitrageHistoryCellView(dataModel: item)):AnyView(CircularArbitrageHistoryCellView(exchangeName: item.maxExchange ?? ""))
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
            }
            .navigationTitle(StringKeys.history)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TabView {
        HistoryView()
            .tabItem {
                Image(systemName: Symbols.opportunity_history_icon)
                Text(StringKeys.history)
            }
    }
}
