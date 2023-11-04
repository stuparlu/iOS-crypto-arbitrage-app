//
//  ExchangeListView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct ExchangeListView: View {
    @StateObject var viewModel: PricesViewModel
    var body: some View {
        HStack() {
            Text(StringKeys.displayed.exchange)
            Spacer()
            Text(StringKeys.displayed.highestBid)
            Text(StringKeys.displayed.lowestAsk)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        ZStack {
            viewModel.model.exchangePrices.isEmpty ? AnyView(LoadingIndicatorView()) : AnyView(EmptyView())
            List(viewModel.model.exchangePrices) { item in
                PricesCellView(exchangeName: item.exchange, bidPrice: String(item.bidPrice), askPrice: String(item.askPrice))
                    .listRowSeparator(.hidden)
            }
            .environment(\.defaultMinListRowHeight, 10)
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    TabView {
        PricesView()
            .tabItem {
                Image(systemName: Symbols.price_history_icon)
                Text(StringKeys.displayed.prices)
            }
    }
}
