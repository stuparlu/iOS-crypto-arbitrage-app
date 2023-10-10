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
    
    let dateFormatter = DateFormatter()
    
    init(dataModel: CrossArbitrageHistory) {
        self.pairName = dataModel.pairName ?? ""
        self.minExchange = dataModel.minExchange ?? ""
        self.maxExchange = dataModel.maxExchange ?? ""
        self.askPrice = dataModel.askPrice 
        self.bidPrice = dataModel.bidPrice
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        self.timestamp = formatter.string(from: dataModel.timestamp ?? Date.distantPast)
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
                Text("Exchanges:")
                    .font(.headline)
                Spacer()
                Text(minExchange.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName:"arrow.right")
                    .foregroundStyle(Color.gray)
                Text(maxExchange.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack{
                Text("Price:")
                    .font(.headline)
                Spacer()
                Text((String(askPrice)))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName:"arrow.right")
                    .foregroundStyle(Color.gray)
                Text((String(bidPrice)))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack{
                Text("Time:")
                    .font(.headline)
                Spacer()
                Text(timestamp)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
