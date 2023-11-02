//
//  BinanceRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 21.10.23..
//

import Foundation

struct BinanceRequestHandler: RequestHandler {
    static var exchangeParameters: ExchangeParameters = Exchanges.parameters.binance
        
    static func submitTradeOrder(with orderData: OrderData) async -> TradeResponse {
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.binance)
        guard let credentials = credentials else {
            return TradeResponse.getNullResponse()
        }
        
        let symbol = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: orderData.symbol), at: exchangeParameters.name)
        let orderType = orderData.type == .market ? "MARKET": "LIMIT"
        let body = BinanceMarketRequestBody(
            symbol: symbol, side: orderData.side == .buy ? "BUY" : "SELL", type: orderType, quantity: String(orderData.quantity), timestamp: timestamp)
        var query = "symbol=\(body.symbol)&side=\(body.side)&type=\(body.type)&quantity=\(body.quantity)&timestamp=\(body.timestamp)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: query)
        query += "&signature=\(signature)"
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.submitOrderPath)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-MBX-APIKEY")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return makeTradeResponse(for: data)
        } catch {
            return TradeResponse.getNullResponse()
        }
    }
    
    static func getBalance(symbol: String) async -> Double? {
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(forExchange: Exchanges.names.binance)
        guard let credentials = credentials else {
            return nil
        }
        
        var query = "timestamp=\(timestamp)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: query)
        query += "&signature=\(signature)"
        
        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.getbalancePath)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-MBX-APIKEY")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return makeBalanceResponse(for: data, symbol: symbol)
        } catch {
            return nil
        }
    }
    
    static func makeTradeResponse(for data : Data) -> TradeResponse {
        do {
            let response = try JSONDecoder().decode(BinanceMarketResponseBody.self, from: data)
            if response.status == "FILLED" {
                return TradeResponse(isSuccessful: true, orderID: String(response.orderId))
            } else {
                throw "Error submitting order"
            }
        } catch {
            return TradeResponse.getNullResponse()
        }
    }
    
    static func makeBalanceResponse(for data: Data, symbol: String) -> Double? {
        do {
            let response = try JSONDecoder().decode(BinanceBalanceResponse.self, from: data)
            if response.balances.count > 0, let balance = response.balances.first(where: { $0.asset == symbol}) {
                return Double(balance.free)
            } else {
                throw "Error fetching balance"
            }
        } catch {
            return nil
        }
    }
}

