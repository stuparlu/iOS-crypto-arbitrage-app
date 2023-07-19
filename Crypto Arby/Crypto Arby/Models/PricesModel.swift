//
//  PricesModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation

struct PriceResponse: Decodable {
    let symbol: String
    let price: String
}

class PricesModel {
    
    
    func getPricesForTicker(ticker: String) {
        let url = URL(string: "https://api.binance.com/api/v3/ticker/price?symbol=\(ticker)USDT")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let priceResponse = try decoder.decode(PriceResponse.self, from: data)
                if let price = Double(priceResponse.price) {
                    print(price)
                } else {
                }
            } catch {
            }
        }
        task.resume()
    }
}
