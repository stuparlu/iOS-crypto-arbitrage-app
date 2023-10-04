//
//  CircularArbitragePairSelectionView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.10.23..
//

import SwiftUI

struct CircularArbitragePairSelectionView: View {
    @StateObject var viewModel: NewCircularArbitrageViewModel
    @StateObject var navModel: OpportunitiesNavigationModel
    var body: some View {
        VStack {
            List(viewModel.nextPairs, id: \.searchableName) { item in
                Button {
                    viewModel.addPair(item)
                } label: {
                    Text(item.searchableName)
                }
            }
            .frame(minHeight:0, maxHeight: 220)
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            .searchable(text: $viewModel.searchText, prompt: StringKeys.searchPairsToAdd)
            
            List(viewModel.selectedPairs, id: \.searchableName) { item in
                Button {
                    viewModel.removePair(item)
                } label: {
                    Text(item.searchableName)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            Spacer()
        }
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
