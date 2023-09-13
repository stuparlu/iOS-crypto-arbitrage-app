//
//  OpportunitiesCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 13.9.23..
//

import SwiftUI

struct OpportunitiesCellView: View {
    let pairName: String
    @State var isActive: Bool
    let exchanges: [String]
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(pairName)
                    .frame(maxWidth: .infinity, alignment:.leading)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                ForEach(exchanges, id: \.self) {
                    Text($0.capitalized)
                        .frame(maxWidth: .infinity, alignment:.leading)
                }
            }
            Spacer(minLength: 30)
            VStack {
                Button(action: {}) {
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

struct OpportunitiesCellView_Previews: PreviewProvider {
    static var previews: some View {
        OpportunitiesCellView(pairName: "BTCUSDT", isActive: true, exchanges: ["Binance", "Bitfinex"])
    }
}
