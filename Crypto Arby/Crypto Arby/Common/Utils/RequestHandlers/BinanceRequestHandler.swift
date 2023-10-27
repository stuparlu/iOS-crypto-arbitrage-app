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

struct BinanceMarketResponseBody: Codable {
    let clientOrderId: String
        let cummulativeQuoteQty: String
        let executedQty: String
        let fills: [BinanceMarketFills]
        let orderId: Int
        let orderListId: String
        let origQty: String
        let price: String
        let selfTradePreventionMode: String
        let side: String
        let status: String
        let symbol: String
        let timeInForce: String
        let transactTime: Int
        let type: String
        let workingTime: Int
}

struct BinanceMarketFills: Codable {
    let commission: String
    let commissionAsset: String
    let price: String
    let qty: String
    let tradeId: Int
}

struct BinanceRequestHandler: RequestHandler {
    static let exchangeParameters = Exchanges.parameters.binance
    
    static func submitMarketOrder(symbol: String, side: TradeSide, amount: Double) async throws -> TradeResponse {        
        let timestamp = CryptographyHandler.getCurrentUTCTimestampInMilliseconds()
        let credentials = KeychainManager.shared.retriveConfiguration(for: Exchanges.names.binance)
        guard let credentials = credentials else {
            return TradeResponse.getNullResponse()
        }
        
        let body = BinanceMarketRequestBody(
            symbol: symbol, side: side == .buy ? "BUY" : "SELL", type: "MARKET", quantity: String(amount), timestamp: timestamp)
        var query = "symbol=\(body.symbol)&side=\(body.side)&type=\(body.type)&quantity=\(body.quantity)&timestamp=\(body.timestamp)"
        let signature = CryptographyHandler.hmac256(key: credentials.apiSecret, data: query)
        query += "&signature=\(signature)"

        let url = URL(string: "\(exchangeParameters.apiEndpoint)\(exchangeParameters.submitOrderPath)?\(query)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(credentials.apiKey, forHTTPHeaderField: "X-MBX-APIKEY")
        let (data, _) = try await URLSession.shared.data(for: request)
        return makeTradeResponse(for: data)
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
}
    
