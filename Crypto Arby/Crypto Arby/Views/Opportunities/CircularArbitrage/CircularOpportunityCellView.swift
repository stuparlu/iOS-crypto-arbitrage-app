//
//  OpportunitiesCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import SwiftUI

struct CircularOpportunitiesCellView: View {
    let dataBaseItem: CircularArbitrageOpportunity
    let exchangeName: String
    @State var isActive: Bool
    let pairs: [String]
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(exchangeName.capitalized)
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                ForEach(pairs, id: \.self) {
                    Text($0.uppercased())
                        .frame(maxWidth: .infinity, alignment:.leading)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)

                }
            }
            Spacer(minLength: 30)
            VStack {
                Button(action: {
                    DatabaseManager.shared.deleteCircularOpportunity(item: dataBaseItem)
                }) {
                    Image(systemName: Symbols.x_mark_bin)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 32)
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {
                    isActive.toggle()
                }) {
                    Image(systemName: isActive ? Symbols.pause : Symbols.play)
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
