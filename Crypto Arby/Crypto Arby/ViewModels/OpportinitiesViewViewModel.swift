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
    @Published var opportunities : [CrossArbitrageOpportunity] = []
    private var cancellable: AnyCancellable?
    
    init() {
        self.opportunities = DatabaseManager.shared.getAllOpportunities()
        self.cancellable = DatabaseManager.shared.$changes
            .sink { [weak self] _ in
                self?.opportunities = DatabaseManager.shared.getAllOpportunities()
            }
    }
}
