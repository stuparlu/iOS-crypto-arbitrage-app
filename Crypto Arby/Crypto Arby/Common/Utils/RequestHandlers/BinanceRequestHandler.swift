//
//  BinanceRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 21.10.23..
//

import Foundation

struct BinanceMarketRequestBody: Codable {
    var symbol: String
    var side: String
    var type: String
    var quantity: String
    var timestamp: String
}

struct BinanceRequestHandler {
    static let endpoint = "https://testnet.binance.vision"
    static let submitOrderPath = "/api/v3/order"
    
    static func submitOrder(symbol: String, amount: String) {
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(for: Exchanges.names.binance)
        guard let credentials = credentials else {
            return
        }
        let body = BinanceMarketRequestBody(symbol: symbol, side: "BUY", type: "MARKET", quantity: amount, timestamp: timestamp)
        var query = "symbol=\(body.symbol)&side=\(body.side)&type=\(body.type)&quantity=\(body.quantity)&timestamp=\(body.timestamp)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: query)
        query += "&signature=\(signature)"

        let url = URL(string: "\(endpoint)\(submitOrderPath)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-MBX-APIKEY")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                }
            }
        }
        task.resume()
    }
}
    
