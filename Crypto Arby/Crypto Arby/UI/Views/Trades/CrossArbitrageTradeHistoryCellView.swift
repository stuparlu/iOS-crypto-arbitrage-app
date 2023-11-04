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
        self.bidOrderID = dataModel.bidOrderID ?? StringKeys.placeholders.none
        self.askOrderID = dataModel.askOrderID ?? StringKeys.placeholders.none
        self.status = dataModel.success ? StringKeys.displayed.success : StringKeys.displayed.failed
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
            Text("\(StringKeys.displayed.status)\(status)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(StringKeys.displayed.description)\(message)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            VStack {
                HStack {
                    Text("\(StringKeys.displayed.boughtAt)\(askExchange)")
                    Spacer()
                    Text("\(StringKeys.displayed.soldAt)\(bidExchange)")
                }
                HStack {
                    Text("\(StringKeys.displayed.amount) \(bidAmount)")
                    Spacer()
                    Text("\(StringKeys.displayed.amount) \(askAmount)")
                }
                HStack {
                    Text("\(StringKeys.displayed.price) \(askPrice)")
                    Spacer()
                    Text("\(StringKeys.displayed.price) \(bidPrice)")
                }
                HStack {
                    Text("\(StringKeys.displayed.orderID)\(askOrderID)")
                    Spacer()
                    Text("\(StringKeys.displayed.orderID)\(bidOrderID)")
                }
                Text("\(StringKeys.displayed.time) \(timestamp)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
