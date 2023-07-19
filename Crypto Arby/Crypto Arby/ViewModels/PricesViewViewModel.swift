//
//  PricesViewViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation
import SwiftUI

class PricesViewViewModel: ObservableObject {
    let menuOptions = cryptocurrencies
    var pricesModel = PricesModel()
    @Published var selectedMenuOption: Int = 0
    @Published var selectedMenuOptionText = "\(cryptocurrencies[0][StringKeys.coin_ticker]!) - \(cryptocurrencies[0][StringKeys.coin_name]!)"
    
    func menuItemChanged(index:Int) {
        selectedMenuOption = index
        selectedMenuOptionText = "\(cryptocurrencies[index][StringKeys.coin_ticker]!) - \(cryptocurrencies[index][StringKeys.coin_name]!)"
        pricesModel.getPricesForTicker(ticker: cryptocurrencies[index][StringKeys.coin_ticker]!)
    }
    
    func fetchMenuItems() -> [Button<Text>] {
        var menuItems: [Button<Text>] = []
        for (index, dict) in cryptocurrencies.enumerated() {
            let button = Button(action: {
                self.menuItemChanged(index: index)
            }) {
                Text("\(dict[StringKeys.coin_ticker]!) - \(dict[StringKeys.coin_name]!)")
            }
            menuItems.append(button)
        }
        return menuItems
    }
    
}
