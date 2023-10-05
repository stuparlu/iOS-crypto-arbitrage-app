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
            viewModel.nextPairs.count != 0 ? AnyView(PairSelectionList(viewModel: viewModel)) : AnyView(EmptyView())
            HStack {
                Text(StringKeys.selectedPairs)
                Spacer()
                Button {
                    viewModel.clearLast()
                } label: {
                    Text(StringKeys.clearLast)
                }
                .buttonStyle(.borderedProminent)
            }
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
            Button {
                viewModel.saveOpportunity()
            } label: {
                Text(StringKeys.saveOpportunity)
                    .frame(width: 150, height: 40)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
