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
            Text(StringKeys.lowest_ask)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        List(viewModel.exchangePrices) { item in
            PricesCellView(exchangeName: item.exchange, bidPrice: item.bidPrice, askPrice: item.askPrice)
                .listRowSeparator(.hidden)
        }
        .environment(\.defaultMinListRowHeight, 10)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        Spacer()
    }
}

#Preview {
    ExchangeListView(viewModel: PricesViewViewModel())
}