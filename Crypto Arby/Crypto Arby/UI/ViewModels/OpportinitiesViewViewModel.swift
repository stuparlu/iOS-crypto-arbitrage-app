//
//  OpportinitiesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import Foundation
import CoreData
import Combine

class OpportinitiesViewViewModel: ObservableObject {
    @Published var crossOpportunities : [CrossArbitrageOpportunity] = []
    @Published var circularOpportunities : [CircularArbitrageOpportunity] = []
    private var cancellable: AnyCancellable?
    
    init() {
        self.crossOpportunities = DatabaseManager.shared.getAllCrossOpportunities()
        self.circularOpportunities = DatabaseManager.shared.getAllCircularOpportunities()
        self.cancellable = DatabaseManager.shared.$changes
            .sink { [weak self] _ in
                self?.crossOpportunities = DatabaseManager.shared.getAllCrossOpportunities()
                self?.circularOpportunities = DatabaseManager.shared.getAllCircularOpportunities()
            }
    }
}
