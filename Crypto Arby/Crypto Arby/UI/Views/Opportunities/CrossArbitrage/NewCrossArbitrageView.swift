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
    @StateObject var navModel: OpportunitiesNavigationModel
    
    var body: some View {
        NavigationView {
            VStack {
                !viewModel.model.pairSelected ? AnyView(CrossArbitrageSearchList(viewModel: viewModel)) : AnyView(CrossArbitrageExchangeSelectionView(viewModel: viewModel, navModel: navModel))
                
            }
            .navigationTitle(StringKeys.displayed.newCrossArbitrage)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                viewModel.model.pairSelected ? AnyView(CrossArbitrageSaveButtonView(viewModel: viewModel)) : AnyView(EmptyView())
            }
        }
        .onChange(of: navModel.shouldDismissToRoot) { value in
            presentationMode.wrappedValue.dismiss()
        }
        .alert(isPresented: $viewModel.model.showAlert) {
            Alert(
                title: Text(StringKeys.errors.generic_error),
                message: Text(StringKeys.alerts.selectExchanges),
                dismissButton: .default(Text(StringKeys.displayed.ok))
            )
        }
    }
}

struct NewCrossArbitrageView_Previews: PreviewProvider {
    static var previews: some View {
        NewCrossArbitrageView(navModel: OpportunitiesNavigationModel())
    }
}
