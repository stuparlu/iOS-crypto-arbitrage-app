//
//  CircularArbitrageHistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 10.10.23..
//

import SwiftUI

struct CircularArbitrageHistoryCellView: View {
    let exchangeName: String
    
    var body: some View {
        Text(exchangeName.capitalized)
    }
}

#Preview {
    CircularArbitrageHistoryCellView(exchangeName: ExchangeNames.binance)
}
