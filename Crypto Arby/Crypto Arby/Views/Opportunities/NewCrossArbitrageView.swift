//
//  NewCrossArbitrageView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct NewCrossArbitrageView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = NewCrossArbitrageViewModel()
    
    var searchResults: [String] {
        if viewModel.searchText.isEmpty {
            return viewModel.tickerList
        } else {
            return viewModel.tickerList.filter { $0.contains(viewModel.searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.pairSelected {
                    List {
                        ForEach(searchResults, id: \.self) { item in
                            Button(action: {
                                viewModel.selectPair(pairName: item)
                            }) {
                                Text(item)
                            }
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: StringKeys.search_pairs)
                    .textInputAutocapitalization(.characters)
                } else {
                    Text("\(StringKeys.pair_selected)\(viewModel.selectedPair)")
                    List {
                        Text(StringKeys.select_exchanges)
                        ForEach(ExchangeNames.exchangesList, id: \.self) { item in
                            Button(action: {
                                viewModel.toggleExchange(exchangeName: item)
                            }) {
                                Text(item)
                            }
                            .foregroundColor(viewModel.isExchangeEnabled(exchangeName:item) ? .white : .black)
                            .background(viewModel.isExchangeEnabled(exchangeName:item) ? Color.accentColor : .white)
                        }
                    }
                    Spacer()
                    Button(action: {
                        viewModel.saveButtonPressed()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 200, height: 60)
                            Text(StringKeys.save_opportunity)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle(StringKeys.new_cross_arbitrage)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                if viewModel.pairSelected {
                    Button(action: {
                        viewModel.pairSelected.toggle()
                    }) {
                        Image(systemName: Symbols.x_mark)
                            .resizable()
                            .frame(width: 20, height:20)
                    }
                }
            }
        }
        .onChange(of: viewModel.shouldDismissView) { value in
            presentationMode.wrappedValue.dismiss()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(StringKeys.errors.generic_error),
                message: Text(StringKeys.alerts.select_exchanges),
                dismissButton: .default(Text(StringKeys.ok))
            )
        }
    }
}

struct NewCrossArbitrageView_Previews: PreviewProvider {
    static var previews: some View {
        NewCrossArbitrageView()
    }
}
