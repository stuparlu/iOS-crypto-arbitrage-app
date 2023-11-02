//
//  BybitRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 21.10.23..
//

import Foundation

struct BybitRequestHandler: RequestHandler {
    static var exchangeParameters: ExchangeParameters = Exchanges.parameters.bybit

    static func submitTradeOrder(with orderData: OrderData) async -> TradeResponse {
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.bybit)
        guard let credentials = credentials else {
            return TradeResponse.getNullResponse()
        }
        
        let symbol = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: orderData.symbol), at: exchangeParameters.name)
        let side = orderData.side == .buy ? "Buy" : "Sell"
        let type = orderData.type == .market ? "Market" : "Limit"
        let body = BybitMarketRequestBody(category: "spot", symbol: symbol, side: side, orderType: type, qty: String(orderData.quantity))
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let jsonData = try! jsonEncoder.encode(body)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let signaturePayload = "\(timestamp)\(credentials.apiKey)\(json!)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.submitOrderPath)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(timestamp, forHTTPHeaderField: "X-BAPI-TIMESTAMP")
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-BAPI-API-KEY")
        request.addValue(signature, forHTTPHeaderField: "X-BAPI-SIGN")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return makeTradeResponse(for: data)
        } catch {
            return TradeResponse.getNullResponse()
        }
    }
    
    static func getBalance(symbol: String) async -> Double? {
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.bybit)
        guard let credentials = credentials else {
            return nil
        }
        let query = "accountType=SPOT&coin=\(symbol)"
        let signaturePayload = "\(timestamp)\(credentials.apiKey)\(query)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: signaturePayload)
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.getbalancePath)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(timestamp, forHTTPHeaderField: "X-BAPI-TIMESTAMP")
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-BAPI-API-KEY")
        request.addValue(signature, forHTTPHeaderField: "X-BAPI-SIGN")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return makeBalanceResponse(for: data)
        } catch {
            return nil
        }
    }
    
    static func makeTradeResponse(for data: Data) -> TradeResponse {
        do {
            let response = try JSONDecoder().decode(BybitMarketResponseBody.self, from: data)
            if response.retCode == 0 {
                return TradeResponse(isSuccessful: true, orderID: response.result.orderId)
            } else {
                throw "Error submitting order"
            }
        } catch {
            return TradeResponse.getNullResponse()
        }
    }
    
    static func makeBalanceResponse(for data: Data) -> Double? {
        do {
            let response = try JSONDecoder().decode(BybitBalanceResponseBody.self, from: data)
            if response.retCode == 0 {
                return Double(response.result.list[0].coin[0].free)
            } else {
                throw "Error fetching balance"
            }
        } catch {
            return nil
        }
    }
}
