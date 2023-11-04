//
//  PairSelectionList.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 5.10.23..
//

import SwiftUI

struct PairSelectionList: View {
    @StateObject var viewModel: NewCircularArbitrageViewModel
    var body: some View {
        Text(StringKeys.displayed.selectPairsToAdd)
        List(viewModel.model.nextPairs, id: \.searchableName) { item in
            Button {
                viewModel.addPair(item)
            } label: {
                Text(item.searchableName)
            }
        }
        .frame(minHeight:0, maxHeight: 220)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
        .searchable(text: $viewModel.model.searchText, prompt: StringKeys.displayed.searchPairsToAdd)
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
