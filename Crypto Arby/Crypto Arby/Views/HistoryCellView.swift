//
//  HistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//

import SwiftUI

struct HistoryCellView: View {
    let pairName: String
    let minExchange: String
    let maxExchange: String
    let askPrice: Double
    let bidPrice: Double
    let timestamp: Date
    
    var body: some View {
        VStack {
            HStack {
                Text(pairName)
                Text("\(minExchange) -> \(maxExchange)")
            }
            HStack{
                Text(DateFormatter().string(from: timestamp))
                Text("\(String(askPrice)) -> \(String(bidPrice))")
            }
        }
    }
}

#Preview {
    HistoryCellView(pairName: "BTCUSDT", minExchange: "Binance", maxExchange: "Bybit", askPrice: 0,bidPrice: 0, timestamp: Date.now)
}
