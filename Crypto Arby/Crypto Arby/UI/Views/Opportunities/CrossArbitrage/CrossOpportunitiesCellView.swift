//
//  OpportunitiesCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import SwiftUI

struct CrossOpportunitiesCellView: View {
    let dataBaseItem: CrossArbitrageOpportunity
    let pairName: String
    @State var isActive: Bool
    @State var isTrading: Bool
    let exchanges: [String]
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(pairName)
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                ForEach(exchanges, id: \.self) {
                    Text($0.capitalized)
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)

                }
            }
            Spacer(minLength: 30)
            VStack {
                Button(action: {
                    DatabaseManager.shared.deleteCrossOpportunity(item: dataBaseItem)
                }) {
                    Image(systemName: Symbols.x_mark_bin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 32)
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {
                    isActive.toggle()
                    dataBaseItem.isActive = isActive
                    dataBaseItem.saveContext()
                }) {
                    Image(systemName: isActive ? Symbols.pause : Symbols.play)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 32)
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {
                    isTrading.toggle()
                    dataBaseItem.tradingActive = isTrading
                    dataBaseItem.saveContext()
                }) {
                    Image(systemName: isTrading ? Symbols.opportunity_trade_icon : Symbols.x_mark)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 32)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            Spacer()
        }
    }
}
