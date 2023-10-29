//
//  CrossArbitrageTradeHistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.10.23..
//

import SwiftUI

struct CrossArbitrageTradeHistoryCellView: View {
    let symbol: String
    let bidExchange: String
    let askExchange: String
    let bidPrice: Double
    let bidAmount: Double
    let askPrice: Double
    let askAmount: Double
    let bidOrderID: String
    let askOrderID: String
    let status: String
    let message: String
    let timestamp: String
    
    init(dataModel: CrossArbitrageTradeHistory) {
        self.symbol = dataModel.symbol ?? ""
        self.bidExchange = dataModel.bidExchange ?? ""
        self.askExchange = dataModel.askExchange ?? ""
        self.bidPrice = dataModel.bidPrice
        self.bidAmount = dataModel.bidAmount
        self.askPrice = dataModel.askPrice
        self.askAmount = dataModel.askAmount
        self.bidOrderID = dataModel.bidOrderID ?? StringKeys.none
        self.askOrderID = dataModel.askOrderID ?? StringKeys.none
        self.status = dataModel.success ? StringKeys.success : StringKeys.failed
        self.message = dataModel.message ?? ""
        self.timestamp = DateHandler.dateToString(dataModel.timestamp)
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(symbol)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            Text("\(StringKeys.status)\(status)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(StringKeys.description)\(message)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack {
                HStack {
                    Text("\(StringKeys.boughtAt)\(askExchange)")
                    Spacer()
                    Text("\(StringKeys.soldAt)\(bidExchange)")
                }
                HStack {
                    Text("\(StringKeys.amount) \(bidAmount)")
                    Spacer()
                    Text("\(StringKeys.amount) \(askAmount)")
                }
                HStack {
                    Text("\(StringKeys.price) \(askPrice)")
                    Spacer()
                    Text("\(StringKeys.price) \(bidPrice)")
                }
                HStack {
                    Text("\(StringKeys.orderID)\(askOrderID)")
                    Spacer()
                    Text("\(StringKeys.orderID)\(bidOrderID)")
                }
                Text("\(StringKeys.time) \(timestamp)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
