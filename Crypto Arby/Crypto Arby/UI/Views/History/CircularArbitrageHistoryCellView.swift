//
//  CircularArbitrageHistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 10.10.23..
//

import SwiftUI

struct CircularArbitrageHistoryCellView: View {
    let dataModel: CircularArbitrageHistory
    let exchangeName: String
    let path: [String]
    let profitPercentage: Double
    let timestamp: String
    
    init(dataModel: CircularArbitrageHistory) {
        self.dataModel = dataModel
        self.exchangeName = dataModel.exchange ?? ""
        self.path = dataModel.pairs ?? []
        self.profitPercentage = dataModel.profitPercentage
        self.timestamp = DateHandler.dateToString(dataModel.timestamp)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(exchangeName.capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack {
                Text(StringKeys.displayed.path)
                    .font(.headline)
                Spacer()
                ForEach(path, id: \.self) { item in
                    Text(item)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    item != path.last ? (AnyView(Image(systemName:Symbols.arrowRight).foregroundStyle(Color.gray))) : AnyView(EmptyView())
                }
            }
            HStack{
                Text(StringKeys.displayed.profit)
                    .font(.headline)
                Spacer()
                Text(("\(String(profitPercentage))\(StringKeys.displayed.signPercent)"))
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
