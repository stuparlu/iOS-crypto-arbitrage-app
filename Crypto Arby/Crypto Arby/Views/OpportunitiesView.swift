//
//  OpportunitiesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import SwiftUI

struct OpportunitiesView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle(StringKeys.opportunities)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                NavigationLink(destination: OpportunityTypePickerView()) {
                    Image(systemName: Symbols.symbol_plus)
                        .resizable()
                        .frame(width: 30, height:30)
                }
            }
        }
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}

struct OpportunityTypePickerView: View {
    var body: some View {
        Spacer()
        NavigationLink(destination: NewCrossArbitrageView()) {
            VStack {
                Image(systemName: Symbols.symbol_circlepath)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(StringKeys.cross_arbitrage)
            }
        }
        Spacer()
        NavigationLink(destination: NewCircularArbitrageView()) {
            VStack {
                Image(systemName: Symbols.symbol_trianglepath)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(StringKeys.circular_arbitrage)
            }
        }
        Spacer()
    }
}

struct NewCrossArbitrageView: View {
    var body: some View {
        Text("New cross")
    }
}

struct NewCircularArbitrageView: View {
    var body: some View {
        Text("New circular")
    }
}

struct OpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            OpportunitiesView()
                .tabItem {
                    Image(systemName: Symbols.opportunities_icon)
                    Text(StringKeys.opportunities)
                }
        }
    }
}
