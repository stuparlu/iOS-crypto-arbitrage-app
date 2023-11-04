//
//  HistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.9.23..
//

import SwiftUI

struct CrossArbitrageHistoryCellView: View {
    let pairName: String
    let minExchange: String
    let maxExchange: String
    let askPrice: Double
    let bidPrice: Double
    let timestamp: String

    init(dataModel: CrossArbitrageHistory) {
        self.pairName = dataModel.pairName ?? ""
        self.minExchange = dataModel.minExchange ?? ""
        self.maxExchange = dataModel.maxExchange ?? ""
        self.askPrice = dataModel.askPrice 
        self.bidPrice = dataModel.bidPrice
        self.timestamp = DateHandler.dateToString(dataModel.timestamp)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(pairName)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            HStack {
                Text(StringKeys.displayed.exchanges)
                    .font(.headline)
                Spacer()
                Text(minExchange.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName:Symbols.arrowRight)
                    .foregroundStyle(Color.gray)
                Text(maxExchange.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack{
                Text(StringKeys.displayed.price)
                    .font(.headline)
                Spacer()
                Text((String(askPrice)))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName:Symbols.arrowRight)
                    .foregroundStyle(Color.gray)
                Text((String(bidPrice)))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack{
                Text(StringKeys.displayed.time)
                    .font(.headline)
                Spacer()
                Text(timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
