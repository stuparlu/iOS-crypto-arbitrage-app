//
//  ExchangeListView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct ExchangeListView: View {
    @StateObject var viewModel: PricesViewViewModel
    var body: some View {
        HStack() {
            Text(StringKeys.exchange)
            Spacer()
            Text(StringKeys.highest_bid)
            Text(StringKeys.lowestAsk)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        ZStack {
            viewModel.exchangePrices.isEmpty ? AnyView(LoadingIndicatorView()) : AnyView(EmptyView())
            List(viewModel.exchangePrices) { item in
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
                Text(StringKeys.prices)
            }
    }
}
