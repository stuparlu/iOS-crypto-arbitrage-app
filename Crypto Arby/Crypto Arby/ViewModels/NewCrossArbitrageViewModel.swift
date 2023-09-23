//
//  NewCrossArbitrageViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 27.7.23..
//

import Foundation

class NewCrossArbitrageViewModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    let tickerList = cryptocurrencies
    
    @Published var searchText = StringKeys.empty_string
    @Published var selectedPair = StringKeys.empty_string
    @Published var pairSelected = false
    @Published var selectedExchanges: [String] = []
    @Published var showAlert = false
    @Published var shouldDismissView: Bool = false
    
    func selectPair(pairName: String) {
        selectedPair = pairName
        pairSelected.toggle()
    }
    
    func toggleExchange(exchangeName: String) {
        if selectedExchanges.contains(exchangeName) {
            selectedExchanges.removeAll() { $0 == exchangeName}
        } else {
            selectedExchanges.append(exchangeName)
        }
    }
    
    func isExchangeEnabled(exchangeName:String) -> Bool {
        return selectedExchanges.contains(exchangeName)
    }
    
    func saveButtonPressed() {
        if selectedPair == StringKeys.empty_string || selectedExchanges.count <= 1 {
            showAlert.toggle()
        } else {
            saveNewOpportunity()
        }
    }
    
    func saveNewOpportunity() {
        let newOpportunity = CrossArbitrageOpportunity(context: viewContext)
        newOpportunity.isActive = true
        newOpportunity.pairName = selectedPair
        newOpportunity.selectedExchanges = selectedExchanges
        newOpportunity.history = [false, false]
        do {
            try viewContext.save()
        } catch {}
    }
}
