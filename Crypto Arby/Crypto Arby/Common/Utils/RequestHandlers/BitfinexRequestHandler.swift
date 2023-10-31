//
//  BitfinexRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.10.23..
//

import Foundation


struct BitfinexRequestHandler: RequestHandler {
    
    static let exchangeParameters = Exchanges.parameters.bitfinex
    
    static func getNonce() -> String {
        let nonceString = String((Date().timeIntervalSince1970 * 1000000).rounded())
        return String(nonceString[..<nonceString.firstIndex(of: ".")!])
    }
    
    static func submitMarketOrder(symbol: String, side: TradeSide, amount: Double) async throws -> TradeResponse {
        let nonce = getNonce()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.bitfinex)
        guard let credentials = credentials else {
            return TradeResponse.getNullResponse()
        }
        var tradeAmount = amount
        if side == .sell {
            tradeAmount = -tradeAmount
        }
        let body = BitfinexMarketRequestBody(type: "EXCHANGE MARKET", symbol: symbol, amount:String(tradeAmount))
        
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
        let (data, _) = try await URLSession.shared.data(for: request)
        return makeTradeResponse(for: data)
    }
    
    static func getBalance(symbol: String) async -> Double? {
        let nonce = getNonce()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.bitfinex)
        guard let credentials = credentials else {
            return nil
        }
        
        let signaturePayload = "/api/\(exchangeParameters.getbalancePath)\(nonce)"
        let signature = CryptographyHandler.hmac384(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.getbalancePath)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(nonce, forHTTPHeaderField: "bfx-nonce")
        request.addValue(credentials.apiKey, forHTTPHeaderField: "bfx-apikey")
        request.addValue(signature, forHTTPHeaderField: "bfx-signature")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return makeBalanceResponse(for: data, symbol: symbol)
        } catch {
            return nil
        }
    }
    
    static func makeTradeResponse(for data: Data) -> TradeResponse {
        do {
            if let json = String(data: data, encoding: .utf8), json.contains("SUCCESS") {
                let pattern = #"(\d+)"#
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let range = NSRange(json.startIndex..<json.endIndex, in: json)
                let matches = regex.matches(in: json, options: [], range: range)
                let matchRange = matches[1].range
                let orderID = String(json.prefix(matchRange.upperBound).suffix(matchRange.upperBound - matchRange.lowerBound))
                return TradeResponse(isSuccessful: true, orderID: orderID)
            } else {
                throw "Error Submitting order"
            }
        } catch {
            return TradeResponse.getNullResponse()
        }
    }
    
    static func makeBalanceResponse(for data: Data, symbol: String) -> Double? {
        let searchSymbol = symbol.replacingOccurrences(of: "t", with: "")
        if let dataString = String(data: data, encoding: .utf8)?
            .replacingOccurrences(of: "[[", with: "[")
            .replacingOccurrences(of: "]]", with: "]") {
    
            let pattern = "(\\[.*?\\])"
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: dataString, options: [], range: NSRange(location: 0, length: dataString.utf16.count))
            var substrings: [String] = []
            var previousRange = NSRange(location: 0, length: 0)
            
            for match in matches {
                let range = match.range
                if let swiftRange = Range(range, in: dataString) {
                    let substring = String(dataString[swiftRange])
                    let intermediateSubstringRange = NSRange(location: previousRange.upperBound, length: range.lowerBound - previousRange.upperBound)
                    if let intermediateRange = Range(intermediateSubstringRange, in: dataString) {
                        let intermediateSubstring = String(dataString[intermediateRange])
                        substrings.append(intermediateSubstring)
                    }
                    substrings.append(substring)
                    previousRange = range
                }
            }
            if let symbolString = substrings.first(where: {
                $0.contains("\(searchSymbol)\"") && $0.contains("exchange")
            }) {
               let symbolData = symbolString.split(separator: ",")
                let symbolBalance = symbolData[4]
                return Double(symbolBalance)
            }
        }
        return nil
    }
}
