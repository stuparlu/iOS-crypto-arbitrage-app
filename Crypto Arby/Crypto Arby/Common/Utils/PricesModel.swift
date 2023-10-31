//
//  PricesModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation

struct PricesModel {
    static func getPricesFor(ticker: String, at exchange: String) async -> BidAskData? {
        do {
            let exchangePairName = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ticker), at: exchange)
            if let url = URL(string: Exchanges.mapper.getSymbolUrl(for: exchange, ticker: exchangePairName)) {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                return try parseData(data, for: exchange, ticker: ticker)
            } else {
                throw URLError(.badURL)
            }
        } catch {
            DispatchQueue.main.async {
                print("Error retrieving data for \(ticker) at \(exchange): \(error)")
            }
            return nil
        }
    }
    
    static func parseData(_ data: Data, for exchange: String, ticker: String) throws -> BidAskData? {
        let decoder = JSONDecoder()
        let responseType = Exchanges.mapper.getResponseType(for: exchange)
        if let priceResponse = try decoder.decode(responseType, from: data) as? PriceResponse {
            return priceResponse.fetchBidAskData(exchange: exchange, ticker: ticker)
        } else {
            throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error retrieving bid-ask data for \(ticker) at \(exchange)"])
        }
    }
}
