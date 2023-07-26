//
//  NewCrossArbitrageView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct NewCrossArbitrageView: View {
    let data = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
            .navigationTitle(StringKeys.new_cross_arbitrage)
        }
        .searchable(text: $searchText)
    }
}

struct NewCrossArbitrageView_Previews: PreviewProvider {
    static var previews: some View {
        NewCrossArbitrageView()
    }
}
