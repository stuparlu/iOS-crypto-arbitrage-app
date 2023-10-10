//
//  CrossArbitrageExchangeSelectionView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CrossArbitrageExchangeSelectionView: View {
    @StateObject var viewModel: NewCrossArbitrageViewModel
    @StateObject var navModel: OpportunitiesNavigationModel
    
    var body: some View {
        Spacer()
        Text("\(StringKeys.pair_selected)\(viewModel.selectedPair)")
        List {
            Text(StringKeys.select_exchanges)
            ForEach(ExchangeNames.exchangesList, id: \.self) { item in
                Button(action: {
                    viewModel.toggleExchange(exchangeName: item)
                }) {
                    Text(item.capitalized)
                }
                .foregroundColor(viewModel.isExchangeEnabled(exchangeName:item) ? .white : .gray)
                .background(viewModel.isExchangeEnabled(exchangeName:item) ? Color.accentColor : .clear)
            }
        }
        .padding(.horizontal, 0)
        .scrollContentBackground(.hidden)
        .background(Color(ThemeManager.backgroundColor))
        Spacer()
        Button(action: {
            viewModel.saveButtonPressed()
            navModel.shouldDismissToRoot.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200, height: 60)
                Text(StringKeys.saveOpportunity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(ThemeManager.backgroundColor))
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    NewCrossArbitrageView(navModel: OpportunitiesNavigationModel())
}
