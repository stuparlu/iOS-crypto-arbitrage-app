//
//  CrossArbitrageSaveButtonView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.9.23..
//

import SwiftUI

struct CrossArbitrageSaveButtonView: View {
    @StateObject var viewModel: NewCrossArbitrageViewModel
    
    var body: some View {
        Button(action: {
            viewModel.model.pairSelected.toggle()
        }) {
            Image(systemName: Symbols.x_mark)
                .resizable()
                .frame(width: 20, height:20)
        }
    }
}

#Preview {
    CrossArbitrageSaveButtonView(viewModel: NewCrossArbitrageViewModel())
}
