//
//  OpportinitiesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 25.7.23..
//

import Foundation
import CoreData
import Combine

class OpportunitiesViewModel: ObservableObject {
    @Published var model = OpportunitiesModel()
    private var cancellable: AnyCancellable?
    
    init() {
        self.model.crossOpportunities = DatabaseManager.shared.getAllCrossOpportunities()
        self.model.circularOpportunities = DatabaseManager.shared.getAllCircularOpportunities()
        self.cancellable = DatabaseManager.shared.$changes
            .sink { [weak self] _ in
                self?.model.crossOpportunities = DatabaseManager.shared.getAllCrossOpportunities()
                self?.model.circularOpportunities = DatabaseManager.shared.getAllCircularOpportunities()
            }
    }
    
    func fetchCrossOpportunities() -> [CrossArbitrageOpportunity] {
        return model.crossOpportunities
    }
    
    func fetchCircularOpportunities() -> [CircularArbitrageOpportunity] {
        return model.circularOpportunities
    }
}
