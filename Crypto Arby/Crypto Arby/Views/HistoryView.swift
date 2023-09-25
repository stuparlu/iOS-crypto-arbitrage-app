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
        VStack {
            List(viewModel.history) { item in
                HistoryCellView(pairName: item.pairName ?? "NONE", minExchange: item.minExchange ?? "NONE", maxExchange: item.maxExchange ?? "NONE", askPrice: item.askPrice, bidPrice: item.bidPrice, timestamp: item.timestamp ?? Date.distantPast)
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    HistoryView()
}
