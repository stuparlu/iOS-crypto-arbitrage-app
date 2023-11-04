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
        if viewModel.model.searchText.isEmpty {
            return Array(viewModel.getTickers())
        } else {
            return Array(viewModel.getTickers().filter { $0.contains(viewModel.model.searchText)
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
        .searchable(text: $viewModel.model.searchText, prompt: StringKeys.displayed.searchPairs)
        .textInputAutocapitalization(.characters)
    }
}

#Preview {
    NewCrossArbitrageView(navModel: OpportunitiesNavigationModel())
}
