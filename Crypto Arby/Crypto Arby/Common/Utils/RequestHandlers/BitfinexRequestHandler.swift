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

struct BitfinexRequestHandler: RequestHandler {
    static let exchangeParameters = Exchanges.parameters.bitfinex
    
    static func getNonce() -> String {
        let nonceString = String((Date().timeIntervalSince1970 * 1000000).rounded())
        return String(nonceString[..<nonceString.firstIndex(of: ".")!])
    }
    
    static func submitMarketOrder(symbol: String, side: TradeSide, amount: Double) {
        let nonce = getNonce()
        let credentials = KeychainManager.shared.retriveConfiguration(for: Exchanges.names.bitfinex)
        guard let credentials = credentials else {
            return
        }
        var tradeAmount = amount
        if side == .sell {
            tradeAmount = -tradeAmount
        }
        let body = MarketRequestBody(type: "EXCHANGE MARKET", symbol: symbol, amount:String(tradeAmount))
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = try! jsonEncoder.encode(body)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let signaturePayload = "/api/\(exchangeParameters.submitOrderPath)\(nonce)\(json!)"
        let signature = CryptographyHandler.hmac384(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.submitOrderPath)")!
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
