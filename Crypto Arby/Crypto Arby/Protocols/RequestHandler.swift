//
//  RequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 26.10.23..
//

import Foundation

protocol RequestHandler {
    static var exchangeParameters: ExchangeParameters {get set}
    
    static func getBidAskData(for ticker: String) async -> BidAskData?
    static func submitTradeOrder(with orderData: OrderData) async -> TradeResponse
    static func getBalance(symbol: String) async -> Double?
}

extension RequestHandler {
    static func getBidAskData(for ticker: String) async -> BidAskData? {
        do {
            let exchangePairName = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ticker), at: exchangeParameters.name)
            if let url = URL(string: Exchanges.mapper.getSymbolUrl(for: exchangeParameters.name, ticker: exchangePairName)) {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                return try makeBidAskResponse(for: data, for: exchangeParameters.name, ticker: ticker)
            } else {
                throw URLError(.badURL)
            }
        } catch {
            DispatchQueue.main.async {
                print("Error retrieving data for \(ticker) at \(exchangeParameters.name): \(error)")
            }
            return nil
        }
    }
    
    static func makeBidAskResponse(for data: Data, for exchange: String, ticker: String) throws -> BidAskData? {
        let decoder = JSONDecoder()
        let responseType = Exchanges.mapper.getResponseType(for: exchange)
        if let priceResponse = try decoder.decode(responseType, from: data) as? PriceResponse {
            return priceResponse.fetchBidAskData(exchange: exchange, ticker: ticker)
        } else {
            throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error retrieving bid-ask data for \(ticker) at \(exchange)"])
        }
    }
}
