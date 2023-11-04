//
//  NewCircularArbitrageView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct NewCircularArbitrageView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = NewCircularArbitrageViewModel()
    @StateObject var navModel: OpportunitiesNavigationModel
    
    var body: some View {
        NavigationView {
            VStack {
                !viewModel.model.exchangeSelected ? AnyView(CircularArbitrageExchangeSearchForm(viewModel: viewModel)) : AnyView(CircularArbitragePairSelectionView(viewModel: viewModel, navModel: navModel))
                
            }
            .navigationTitle(StringKeys.displayed.newCircularArbitrage)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                viewModel.model.exchangeSelected ? AnyView(CircularArbitrageCancelButtonView(viewModel: viewModel)) : AnyView(EmptyView())
            }
            CircularArbitragePairSelectionView(viewModel: viewModel, navModel: navModel)
        }
        .onChange(of: navModel.shouldDismissToRoot) { value in
            presentationMode.wrappedValue.dismiss()
        }
        .alert(StringKeys.alerts.circularSaveFailedTitle, isPresented: $viewModel.model.saveAlertShown) {
            Button(StringKeys.displayed.ok, role: .cancel) {}
        } message: {
            Text(StringKeys.alerts.circularSaveFailedMessage)
        }
    }
}

#Preview {
    NewCircularArbitrageView(navModel: OpportunitiesNavigationModel())
}
