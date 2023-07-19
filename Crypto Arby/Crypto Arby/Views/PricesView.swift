//
//  PricesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import SwiftUI

struct PricesView: View {
    @State private var selectedOption: String?
    private let listItems = ["Item 1", "Item 2", "Item 3", "Item 4"]
    @ObservedObject var viewModel = PricesViewViewModel()
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
            
            List(listItems, id: \.self) { item in
                Text(item)
                    .listRowBackground(Color.white)
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
