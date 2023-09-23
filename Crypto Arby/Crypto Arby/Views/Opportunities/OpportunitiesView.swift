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
                    List(viewModel.opportunities) { item in
                        if let name = item.pairName, let exchanges = item.selectedExchanges {
                            OpportunitiesCellView(pairName: name, isActive: item.isActive, exchanges: exchanges)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(PlainListStyle())
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
