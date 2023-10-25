//
//  PricesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import SwiftUI

struct PricesView: View {
    @StateObject var viewModel = PricesViewViewModel()
    
    var body: some View {
        VStack {
            viewModel.isNavigationViewHidden ? AnyView(CurrencyTogglerView(viewModel: viewModel)) : AnyView(CurrencySearchView(viewModel: viewModel))
            viewModel.isNavigationViewHidden ? AnyView(ExchangeListView(viewModel: viewModel)) : AnyView(EmptyView())
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
