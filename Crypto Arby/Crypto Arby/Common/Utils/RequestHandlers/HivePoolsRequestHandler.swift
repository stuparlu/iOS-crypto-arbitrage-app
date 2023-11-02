//
//  HivePoolsRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 2.11.23..
//

import Foundation

struct HivePoolsPriceRequest: Codable {
    var jsonrpc: String = "2.0"
    var id: Int = 1
    var method: String = "find"
    let params: HivePoolsPriceParameters
    var offset = 0
    var limit = 1000
    
    init(pair: String) {
        self.params = HivePoolsPriceParameters(pair: pair)
    }
}

struct HivePoolsPriceParameters: Codable {
    var contract = "marketpools"
    var table = "pools"
    let query: HivePoolsPriceQuery
    
    init(pair: String) {
        self.query = HivePoolsPriceQuery(tokenPair: pair)
    }
}

struct HivePoolsPriceQuery: Codable {
    let tokenPair: String
}

struct HivePoolsPriceResponse: Codable {
    let jsonrpc: String
    let id: Int
    let result: [HivePoolsPriceResult]
}

struct HivePoolsPriceResult : Codable {
    let tokenPair: String
    let baseQuantity: String
    let baseVolume: String
    let basePrice: String
    let quoteQuantity: String
    let quoteVolume: String
    let quotePrice: String
    let totalShares: String
    let precision: Int
    let creator: String
}

struct HivePoolsRequestHandler {
    static let exchangeParameters = Exchanges.parameters.hivePools
    
    static func getBidAskData(for ticker: String) async -> BidAskData? {
        let exchangePairName = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ticker), at: exchangeParameters.name)
        let url = URL(string: exchangeParameters.getSymbolUrl)!
        let body = HivePoolsPriceRequest(pair: exchangePairName)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let data = try! jsonEncoder.encode(body)
        
        if let requesteString = String(data: data, encoding: .utf8) {
            print(requesteString)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        do {
            let (response, _) = try await URLSession.shared.data(for: request)
            return makeBidAskResponseFor(symbol: ticker, data: response)
        } catch {
            DispatchQueue.main.async {
                print("Error retrieving data for \(ticker) at \(exchangeParameters.name.capitalized): \(error)")
            }
            return nil
        }
    }
    
    static func makeBidAskResponseFor(symbol: String, data: Data) -> BidAskData? {
        do {
            let response = try JSONDecoder().decode(HivePoolsPriceResponse.self, from: data)
            if response.result.count > 0  {
                let responseData = response.result[0]
                guard let baseQuantity = Double(responseData.baseQuantity),
                      let basePrice = Double(responseData.basePrice),
                      let quoteQuantity = Double(responseData.quoteQuantity),
                      let quotePrice = Double(responseData.quotePrice) else {
                    throw "Error getting Bid/Ask data."
                }
                let acceptableDeviation = 0.7
                let maxBaseQuantity = quoteQuantity * quotePrice.increaseByPercent(acceptableDeviation) / 100
                let maxQuoteQuantity = baseQuantity * basePrice.increaseByPercent(acceptableDeviation) / 100
                return BidAskData(exchange:
                                  exchangeParameters.name,
                                  symbol: symbol,
                                  bidPrice: basePrice.increaseByPercent(0.3),
                                  askPrice: basePrice.decreaseByPercent(0.3),
                                  bidQuantity: maxQuoteQuantity,
                                  askQuantity: maxBaseQuantity)
            }
            else {
                throw "Error getting Bid/Ask data."
            }
        } catch {
            return nil
        }
    }
    
}
