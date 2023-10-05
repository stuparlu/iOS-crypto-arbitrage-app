//
//  NewCircularArbitrageView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct NewCircularArbitrageView: View {
    @StateObject private var viewModel = NewCircularArbitrageViewModel()
    @StateObject var navModel: OpportunitiesNavigationModel
    
    var body: some View {
        NavigationView {
            VStack {
                !viewModel.exchangeSelected ? AnyView(CircularArbitrageExchangeSearchForm(viewModel: viewModel)) : AnyView(CircularArbitragePairSelectionView(viewModel: viewModel, navModel: navModel))
                
            }
            .navigationTitle(StringKeys.new_circular_arbitrage)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                viewModel.exchangeSelected ? AnyView(CircularArbitrageCancelButtonView(viewModel: viewModel)) : AnyView(EmptyView())
            }
            CircularArbitragePairSelectionView(viewModel: viewModel, navModel: navModel)
        }
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
