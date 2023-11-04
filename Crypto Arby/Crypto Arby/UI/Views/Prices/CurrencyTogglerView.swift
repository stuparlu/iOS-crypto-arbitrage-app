//
//  CurrencyTogglerView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CurrencyTogglerView: View {
    @StateObject var viewModel: PricesViewModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.toggleNavigation()
            }) {
                Label(viewModel.model.selectedMenuOptionText, systemImage: Symbols.symbol_chevron_down)
            }
            Spacer()
        }
    }
}

#Preview {
    CurrencyTogglerView(viewModel:PricesViewModel())
}
