//
//  BitfinexRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.10.23..
//

import Foundation

struct MarketRequestBody: Codable {
    var type: String
    var symbol: String
    var amount: String
}

struct BitfinexRequestHandler {
    static let endpoint = "https://api.bitfinex.com/"
    static let submitOrderPath = "/api/v2/auth/w/order/submit"
    static let apiPath = "v2/auth/w/order/submit"
    
    static func getNonce() -> String {
        let nonceString = String((Date().timeIntervalSince1970 * 1000000).rounded())
        return String(nonceString[..<nonceString.firstIndex(of: ".")!])
    }
    
    static func submitOrder(symbol: String, amount: String) {
        let nonce = getNonce()
        let credentials = KeychainManager.shared.retriveConfiguration(for: ExchangeNames.bitfinex)
        guard let credentials = credentials else {
            return
        }
        let body = MarketRequestBody(type: "MARKET", symbol: symbol, amount:amount)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = try! jsonEncoder.encode(body)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let signaturePayload = "\(submitOrderPath)\(nonce)\(json!)"
        let signature = CryptographyHandler.hmac384(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(endpoint)\(apiPath)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(nonce, forHTTPHeaderField: "bfx-nonce")
        request.addValue(credentials.apiKey, forHTTPHeaderField: "bfx-apikey")
        request.addValue(signature, forHTTPHeaderField: "bfx-signature")
        
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
