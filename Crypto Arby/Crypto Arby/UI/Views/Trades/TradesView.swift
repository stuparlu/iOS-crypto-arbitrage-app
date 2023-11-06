//
//  TradesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.10.23..
//

import SwiftUI

struct TradesView: View {
    let viewModel = TradesViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.model.trades) { item in
                    if String(describing: type(of: item.self)) == String(describing: CrossArbitrageTradeHistory.self) {
                        AnyView(CrossArbitrageTradeHistoryCellView(dataModel: item as! CrossArbitrageTradeHistory))
                    } else if String(describing: type(of: item.self)) == String(describing: CircularArbitrageTradeHistory.self) {
                        AnyView(CircularArbitrageTradeHistoryCellView(dataModel: item as! CircularArbitrageTradeHistory))
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
    TradesView()
}
