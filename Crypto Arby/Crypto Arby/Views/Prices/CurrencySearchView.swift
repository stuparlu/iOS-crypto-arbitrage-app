//
//  CurrencySearchView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CurrencySearchView: View {
    @StateObject var viewModel: PricesViewViewModel
    
    var filteredItems: [String] {
        if viewModel.searchText.isEmpty {
            return Array(viewModel.fetchMenuItems().sorted())
        } else {
            return Array(viewModel.fetchMenuItems().filter { $0.localizedCaseInsensitiveContains(viewModel.searchText)
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
        .background(Color(ThemeManager.backgroundColor))
    }
}

#Preview {
    CurrencySearchView(viewModel: PricesViewViewModel())
}
