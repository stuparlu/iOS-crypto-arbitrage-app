//
//  CircularArbitrageHistoryCellView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 10.10.23..
//

import SwiftUI

struct CircularArbitrageHistoryCellView: View {
    let dataModel: CircularArbitrageHistory
    
    var body: some View {
        Text(dataModel.exchange?.capitalized ?? "")
    }
}
