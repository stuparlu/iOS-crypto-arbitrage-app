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
            ForEach(Exchanges.names.allNames, id: \.self) { item in
                Button(action: {
                    viewModel.toggleExchange(exchangeName: item)
                }) {
                    Text(item.capitalized)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
                .foregroundColor(viewModel.isExchangeEnabled(exchangeName:item) ? .white : .gray)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            viewModel.isExchangeEnabled(exchangeName:item) ? ThemeManager.accentColor : .clear
                        )
                    )
                .listRowSeparator(.hidden)
            }
        }
        .padding(.vertical)
        .scrollContentBackground(.hidden)
        .background(ThemeManager.backgroundColor)
        Spacer()
        Button(action: {
            if viewModel.saveButtonPressed() {
                navModel.shouldDismissToRoot.toggle()
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 200, height: 60)
                Text(StringKeys.saveOpportunity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(ThemeManager.backgroundColor)

            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    NewCrossArbitrageView(navModel: OpportunitiesNavigationModel())
}
