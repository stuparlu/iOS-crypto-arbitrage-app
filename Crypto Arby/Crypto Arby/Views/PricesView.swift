//
//  PricesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import SwiftUI

struct PricesView: View {
    @State private var selectedOption: String?
    @StateObject var viewModel = PricesViewViewModel()
    var body: some View {
        
        VStack {
            Menu {
                ForEach(viewModel.fetchMenuItems().indices, id: \.self) { index in
                    viewModel.fetchMenuItems()[index]
                }
            } label: {
                Label(viewModel.selectedMenuOptionText, systemImage: Symbols.symbol_chevron_down)
                    .frame(maxWidth: .infinity)
            }
            .menuStyle(BorderlessButtonMenuStyle())
            
            HStack() {
                Text(StringKeys.exchange)
                Spacer()
                Text(StringKeys.highest_bid)
                Text(StringKeys.lowest_ask)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
            
            List(viewModel.exchangePrices) { item in
                PricesCellView(exchangeName: item.exchange, bidPrice: item.bidPrice, askPrice: item.askPrice)
                
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
            Spacer()
        }
    }
}

struct PricesView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            PricesView()
                .tabItem {
                    Image(systemName: Symbols.price_history_icon)
                    Text(StringKeys.prices)
                }
        }
    }
}
