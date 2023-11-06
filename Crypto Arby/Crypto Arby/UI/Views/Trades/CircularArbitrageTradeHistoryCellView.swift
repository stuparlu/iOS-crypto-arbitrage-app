//
//  CircularArbitrageTradeHistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 6.11.23..
//

import SwiftUI

struct CircularArbitrageTradeHistoryCellView: View {
    let status: String
    let message: String
    let timestamp: String
    let exchange: String
    let orderIDs: [String]
    let pairs: [String]
    let prices: [Double]
    
    init(dataModel: CircularArbitrageTradeHistory) {
        self.status = dataModel.success ? StringKeys.displayed.success : StringKeys.displayed.failed
        self.message = dataModel.message ?? ""
        self.timestamp = DateHandler.dateToString(dataModel.timestamp)
        self.exchange = dataModel.exchange ?? ""
        self.orderIDs = dataModel.orderIDs ?? []
        self.pairs = dataModel.pairs ?? []
        self.prices = dataModel.prices ?? []
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(exchange.capitalized)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            HStack {
                Text(StringKeys.displayed.status)
                    .font(.headline)
                Spacer()
                Text(status)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(StringKeys.displayed.description)
                    .frame(alignment: .top)
                    .font(.headline)
                Spacer()
                Text(message)
                    .foregroundColor(.gray)
            }
            VStack {
                Text(StringKeys.displayed.pairs)
                    .font(.headline)
                HStack {
                    ForEach(pairs, id: \.self) {
                        Text($0)
                            .font(.system(size: 13))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Text(StringKeys.displayed.qprices)
                    .font(.headline)
                HStack {
                    ForEach(prices, id: \.self) {
                        Text(String($0))
                            .font(.system(size: 13))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                VStack {
                    Text(StringKeys.displayed.orderIDs)
                        .font(.headline)
                    ForEach(orderIDs, id: \.self) {
                        Text($0)
                            .font(.system(size: 13))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Divider()
                    }
                }
            }
            HStack {
                Text(StringKeys.displayed.time)
                    .font(.headline)
                Text(timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}
