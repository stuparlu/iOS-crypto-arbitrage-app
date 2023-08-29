//
//  PricesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import SwiftUI

struct PricesView: View {
    @StateObject var viewModel = PricesViewViewModel()

    var filteredItems: [String] {
        if viewModel.searchText.isEmpty {
            return Array(viewModel.fetchMenuItems().sorted())
        } else {
            return Array(viewModel.fetchMenuItems().filter { $0.localizedCaseInsensitiveContains(viewModel.searchText)
            }.sorted())
        }
    }
        
    var body: some View {
        VStack {
            if viewModel.isNavigationViewHidden {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.isNavigationViewHidden.toggle()
                    }) {
                        Label(viewModel.selectedMenuOptionText, systemImage: Symbols.symbol_chevron_down)
                    }
                    Spacer()
                }
            } else {
                NavigationView {
                        List(filteredItems, id: \.self) { item in
                                Button(action: {
                                    viewModel.closeSearchMenu(item: item)
                                }) {
                                    Text(item)
                                }
                            }
                        .scrollContentBackground(.hidden)
                        .searchable(text: $viewModel.searchText, prompt: StringKeys.search)
                        .navigationTitle(StringKeys.search_pairs)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar() {
                            Button(action: {
                                viewModel.closeSearchMenu(item: nil)
                            }) {
                                Image(systemName: Symbols.x_mark)
                                    .resizable()
                                    .frame(width: 20, height:20)
                            }
                        }
                    Spacer()
                }
                .scrollContentBackground(.hidden)
                .background(Color.white)
            }
            if viewModel.isNavigationViewHidden {
                HStack() {
                    Text(StringKeys.exchange)
                    Spacer()
                    Text(StringKeys.highest_bid)
                    Text(StringKeys.lowest_ask)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                List(viewModel.exchangePrices) { item in
                    PricesCellView(exchangeName: item.exchange, bidPrice: item.bidPrice, askPrice: item.askPrice)
                    
                }
                .scrollContentBackground(.hidden)
                .listStyle(GroupedListStyle())
                Spacer()
            }
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
