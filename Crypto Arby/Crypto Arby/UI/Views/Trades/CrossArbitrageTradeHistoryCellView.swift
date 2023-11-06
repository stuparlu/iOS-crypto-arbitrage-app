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
            Divider()
            VStack {
                HStack {
                    Text(StringKeys.displayed.boughtAt)
                        .font(.headline)
                    Text(askExchange)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(StringKeys.displayed.soldAt)
                        .font(.headline)
                    Text(bidExchange)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(StringKeys.displayed.amount)
                        .font(.headline)
                    Text(String(bidAmount.rounded(toPlaces: 5)))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(StringKeys.displayed.amount)
                        .font(.headline)
                    Text(String(askAmount.rounded(toPlaces: 5)))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(StringKeys.displayed.price)
                        .font(.headline)
                    Text(String(askPrice))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(StringKeys.displayed.price)
                        .font(.headline)
                    Text(String(bidPrice))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(StringKeys.displayed.orderID)
                        .font(.headline)
                    Text(askOrderID)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(StringKeys.displayed.orderID)
                        .font(.headline)
                    Text(bidOrderID)
                        .font(.subheadline)
                        .foregroundColor(.gray)
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
}
