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
                        HistoryCellView(pairName: item.pairName ?? "NONE", minExchange: item.minExchange ?? "NONE", maxExchange: item.maxExchange ?? "NONE", askPrice: item.askPrice, bidPrice: item.bidPrice, timestamp: viewModel.getTimestampString(timestamp: item.timestamp ?? Date.distantPast))
                        .listRowSeparator(.hidden)
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
