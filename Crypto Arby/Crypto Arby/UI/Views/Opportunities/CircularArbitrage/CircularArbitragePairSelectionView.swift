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
            viewModel.model.nextPairs.count != 0 ? AnyView(PairSelectionList(viewModel: viewModel)) : AnyView(EmptyView())
            HStack {
                Text(StringKeys.displayed.selectedPairs)
                Spacer()
                Button {
                    viewModel.clearLast()
                } label: {
                    Text(StringKeys.displayed.clearLast)
                }
                .buttonStyle(.borderedProminent)
            }
            List(viewModel.model.selectedPairs, id: \.searchableName) { item in
                Button {
                    viewModel.removePair(item)
                } label: {
                    Text(item.searchableName)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            Spacer()
            Toggle(StringKeys.displayed.autoTradePrompt, isOn: $viewModel.model.tradingEnabled)
                .disabled(!viewModel.model.autotradeAvailable)
                .tint(ThemeManager.accentColor)
            Button {
                if viewModel.saveOpportunity() {
                    navModel.shouldDismissToRoot.toggle()
                }
            } label: {
                Text(StringKeys.displayed.saveOpportunity)
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
