//
//  OpportunityTypePickerView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct OpportunityTypePickerView: View {
    var body: some View {
        Spacer()
        NavigationLink(destination: NewCrossArbitrageView()) {
            VStack {
                Image(systemName: Symbols.symbol_circlepath)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(StringKeys.cross_arbitrage)
            }
        }
        Spacer()
        NavigationLink(destination: NewCircularArbitrageView()) {
            VStack {
                Image(systemName: Symbols.symbol_trianglepath)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(StringKeys.circular_arbitrage)
            }
        }
        Spacer()
    }
}

struct OpportunityTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityTypePickerView()
    }
}
