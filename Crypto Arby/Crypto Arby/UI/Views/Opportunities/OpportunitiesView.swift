//
//  OpportunitiesView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import SwiftUI

struct OpportunitiesView: View {
    @StateObject var viewModel = OpportinitiesViewViewModel()
    @State private var path: [Int] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    VStack {
                        Text(StringKeys.crossOpportunity)
                            .fontWeight(.bold)
                        List(viewModel.crossOpportunities) { item in
                            if let name = item.pairName, let exchanges = item.selectedExchanges {
                                CrossOpportunitiesCellView(dataBaseItem: item, pairName: name, isActive: item.isActive, exchanges: exchanges)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(PlainListStyle())
                    }
                    Spacer(minLength: 10)
                    VStack {
                        Text(StringKeys.circularOpportunity)
                            .fontWeight(.bold)
                        List(viewModel.circularOpportunities) { item in
                            if let name = item.exchangeName, let pairs = item.selectedPairs {
                                CircularOpportunitiesCellView(dataBaseItem: item, exchangeName: name, isActive: item.isActive, pairs: pairs)
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
                    Text(StringKeys.opportunities)
                }
        }
    }
}
