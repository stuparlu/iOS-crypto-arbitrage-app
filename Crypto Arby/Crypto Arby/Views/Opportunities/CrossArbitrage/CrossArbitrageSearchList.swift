//
//  CrossArbitrageSearchList.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CrossArbitrageSearchList: View {
    @StateObject var viewModel: NewCrossArbitrageViewModel
    var searchResults: [String] {
        if viewModel.searchText.isEmpty {
            return Array(viewModel.getTickers())
        } else {
            return Array(viewModel.getTickers().filter { $0.contains(viewModel.searchText)
            })
        }
    }
    
    var body: some View {
        List(searchResults, id: \.self) { item in
            Button(action: {
                viewModel.selectPair(pairName: item)
            }) {
                Text(item)
            }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(ThemeManager.backgroundColor)
        .searchable(text: $viewModel.searchText, prompt: StringKeys.search_pairs)
        .textInputAutocapitalization(.characters)
    }
}

#Preview {
    NewCrossArbitrageView(navModel: OpportunitiesNavigationModel())
}
