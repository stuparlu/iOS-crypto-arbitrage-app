//
//  PricesCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 24.7.23..
//

import SwiftUI

struct PricesCellView: View {
    let exchangeName: String
    let bidPrice: String
    let askPrice: String
    
    var body: some View {
        HStack() {
            Text(exchangeName.capitalized)
                .font(.headline)
            Spacer()
            Text(bidPrice)
                .font(.subheadline)
                .frame(minWidth: 80, alignment: .trailing)
                .foregroundColor(.gray)
            Text(askPrice)
                .font(.subheadline)
                .frame(minWidth: 80, alignment: .trailing)
                .foregroundColor(.gray)
        }
        .frame(height: 10)
    }
}

struct PricesCellView_Previews: PreviewProvider {
    static var previews: some View {
        PricesCellView(exchangeName: "test", bidPrice: "1.0", askPrice: "0.8")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
