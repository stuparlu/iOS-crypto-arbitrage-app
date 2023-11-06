//
//  OpportunitiesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import SwiftUI

struct OpportunitiesView: View {
    @StateObject var viewModel = OpportunitiesViewModel()
    @State private var path: [Int] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    VStack {
                        Text(StringKeys.displayed.crossOpportunity)
                            .fontWeight(.bold)
                        List(viewModel.fetchCrossOpportunities()) { item in
                            if let name = item.pairName, let exchanges = item.selectedExchanges {
                                CrossOpportunitiesCellView(dataBaseItem: item, pairName: name, isActive: item.isActive, isTrading: item.tradingActive, exchanges: exchanges)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(PlainListStyle())
                    }
                    Spacer(minLength: 10)
                    VStack {
                        Text(StringKeys.displayed.circularOpportunity)
                            .fontWeight(.bold)
                        List(viewModel.fetchCircularOpportunities()) { item in
                            if let name = item.exchangeName, let pairs = item.selectedPairs {
                                CircularOpportunitiesCellView(dataBaseItem: item, exchangeName: name, isActive: item.isActive, isTrading: item.tradingActive, pairs: pairs)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(PlainListStyle())
                    }
                }
                Spacer()
            }
            .padding(.top)
            .navigationTitle(StringKeys.displayed.opportunities)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                NavigationLink(destination: OpportunityTypePickerView()) {
                    Image(systemName: Symbols.symbol_plus)
                        .resizable()
                        .frame(width: 30, height:30)
                }
            }
        }
        .padding(.vertical)
        .edgesIgnoringSafeArea(.all)
    }
}

struct OpportunitiesView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            OpportunitiesView()
                .tabItem {
                    Image(systemName: Symbols.opportunities_icon)
                    Text(StringKeys.displayed.opportunities)
                }
        }
    }
}
