//
//  CircularArbitrageExchangeSearchForm.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.10.23..
//

import SwiftUI

struct CircularArbitrageExchangeSearchForm: View {
    @StateObject var viewModel: NewCircularArbitrageViewModel
    
    var searchResults: [String] {
        if viewModel.model.searchText.isEmpty {
            return Array(viewModel.model.exchangeList).sorted()
        } else {
            return Array(viewModel.model.exchangeList.filter { $0.contains(viewModel.model.searchText)
            }.sorted())
        }
    }

    var body: some View {
        List(searchResults, id: \.self) { item in
            Button(action: {
                viewModel.selectExchange(name: item)
            }) {
                Text(item.capitalized)
            }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(ThemeManager.backgroundColor)
        .searchable(text: $viewModel.model.searchText, prompt: StringKeys.displayed.searchExchanges)
        .textInputAutocapitalization(.characters)
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
