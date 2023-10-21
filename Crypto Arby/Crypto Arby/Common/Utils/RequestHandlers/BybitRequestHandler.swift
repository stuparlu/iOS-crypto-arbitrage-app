//
//  BybitRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 21.10.23..
//

import Foundation

struct BybitMarketRequestBody: Codable {
    let category: String
    let symbol: String
    let side: String
    let orderType: String
    let qty: String
}

struct BybitRequestHandler {
    static let endpoint = "https://api-testnet.bybit.com/"
    static let submitOrderPath = "/v5/order/create"
    
    static func getCurrentUTCTimestampInMilliseconds() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let currentDateString = dateFormatter.string(from: currentDate)
        if let utcDate = dateFormatter.date(from: currentDateString) {
            return String(Int64(utcDate.timeIntervalSince1970 * 1000))
        } else {
            return "0"
        }
    }
    
    static func submitOrder(symbol: String, amount: String) {
        let timestamp = getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(for: ExchangeNames.bybit)
        guard let credentials = credentials else {
            return
        }
        let body = BybitMarketRequestBody(category: "spot", symbol: symbol, side: "Buy", orderType: "Market", qty: amount)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = try! jsonEncoder.encode(body)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let signaturePayload = "\(timestamp)\(credentials.apiKey)\(json!)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(endpoint)\(submitOrderPath)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(timestamp, forHTTPHeaderField: "X-BAPI-TIMESTAMP")
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-BAPI-API-KEY")
        request.addValue(signature, forHTTPHeaderField: "X-BAPI-SIGN")
        
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
