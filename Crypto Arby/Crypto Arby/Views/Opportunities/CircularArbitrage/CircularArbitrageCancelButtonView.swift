//
//  CircularArbitrageCancelButtonView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.10.23..
//

import SwiftUI

struct CircularArbitrageCancelButtonView: View {
    @StateObject var viewModel: NewCircularArbitrageViewModel
    
    var body: some View {
        Button(action: {
            viewModel.exchangeSelected.toggle()
        }) {
            Image(systemName: Symbols.x_mark)
                .resizable()
                .frame(width: 20, height:20)
        }
    }
}

#Preview {
    CircularArbitrageCancelButtonView(viewModel: NewCircularArbitrageViewModel())
}
