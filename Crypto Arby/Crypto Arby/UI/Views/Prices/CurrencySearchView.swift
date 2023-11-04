//
//  CurrencySearchView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CurrencySearchView: View {
    @StateObject var viewModel: PricesViewModel
    
    var filteredItems: [String] {
        if viewModel.model.searchText.isEmpty {
            return Array(viewModel.fetchMenuItems().sorted())
        } else {
            return Array(viewModel.fetchMenuItems().filter { $0.localizedCaseInsensitiveContains(viewModel.model.searchText)
            }.sorted())
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredItems, id: \.self) { item in
                Button(action: {
                    viewModel.closeSearchMenu(item: item)
                }) {
                    Text(item)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .searchable(text: $viewModel.model.searchText, prompt: StringKeys.displayed.search)
            .navigationTitle(StringKeys.displayed.searchPairs)
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
        .background(ThemeManager.backgroundColor)
    }
}

#Preview {
    CurrencySearchView(viewModel: PricesViewModel())
}
