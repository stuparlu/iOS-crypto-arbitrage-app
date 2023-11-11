//
//  AccountViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation
import SwiftUI

class AccountViewModel: ObservableObject {
    @StateObject var model = AccountModel()
    
    var percentageThreshold: Binding<String> {
        return $model.percentageThreshold
    }
    
    var showingManageExchanges: Binding<Bool> {
        return $model.showingManageExchanges
    }
    
    var showingManageWallets: Binding<Bool> {
        return $model.showingManageWallets
    }
    
    func toggleShowingExchanges() {
        model.showingManageExchanges.toggle()
    }
    
    func toggleShowingWallets() {
        model.showingManageExchanges.toggle()
    }
    
    func savePercentageThreshold() {
        SettingsManager.shared.setPercentageThreshold(Double(model.percentageThreshold)!)
    }
}
