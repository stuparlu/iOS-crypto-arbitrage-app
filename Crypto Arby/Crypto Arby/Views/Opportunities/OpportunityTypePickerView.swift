//
//  OpportunityTypePickerView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.7.23..
//

import SwiftUI

struct OpportunityTypePickerView: View {    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var navModel = OpportunitiesNavigationModel()
    
    var body: some View {
        Spacer()
        NavigationLink(destination: NewCrossArbitrageView(navModel: navModel)) {
            VStack {
                Image(systemName: Symbols.symbol_circlepath)
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(StringKeys.cross_arbitrage)
            }
        }
        .onChange(of: navModel.shouldDismissToRoot) { value in
            presentationMode.wrappedValue.dismiss()
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

struct OpportunityTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        OpportunityTypePickerView()
    }
}
