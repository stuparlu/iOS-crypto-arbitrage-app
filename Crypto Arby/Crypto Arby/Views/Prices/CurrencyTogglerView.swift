//
//  CurrencyTogglerView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CurrencyTogglerView: View {
    @StateObject var viewModel: PricesViewViewModel
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                viewModel.isNavigationViewHidden.toggle()
            }) {
                Label(viewModel.selectedMenuOptionText, systemImage: Symbols.symbol_chevron_down)
            }
            Spacer()
        }
    }
}

#Preview {
    CurrencyTogglerView(viewModel:PricesViewViewModel())
}
