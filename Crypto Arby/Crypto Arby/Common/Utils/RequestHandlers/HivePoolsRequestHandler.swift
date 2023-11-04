//
//  HivePoolsRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 2.11.23..
//

import Foundation
import Steem

struct HivePoolsRequestHandler: RequestHandler {
    static var exchangeParameters: ExchangeParameters = Exchanges.parameters.hivePools
    
    static func getBidAskData(for ticker: String) async -> BidAskData? {
        let exchangePairName = Exchanges.mapper.getSearchableName(for: Cryptocurrencies.findPair(by: ticker), at: exchangeParameters.name)
        let url = URL(string: exchangeParameters.getSymbolUrl)!
        let body = HivePoolsPriceRequest(pair: exchangePairName)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let data = try! jsonEncoder.encode(body)
        
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
    
    static func submitTradeOrder(with orderData: OrderData) async -> TradeResponse {
        do {
            let exchangePair = Cryptocurrencies.findPair(by: orderData.symbol)
            let requestBody = HivePoolsMarketTradeRequest(symbol: exchangePair, data: orderData)
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .sortedKeys
            let jsonData = try jsonEncoder.encode(requestBody)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            if let url = URL(string: exchangeParameters.apiEndpoint) {
                if let transactionData = HiveTransactionBroadcaster.broadCastTransaction(to: url, with: jsonString) {
                    let id = String(data: transactionData.id, encoding: .utf8)
                    return TradeResponse(isSuccessful: !transactionData.expired, orderID: id ?? "(none)")
                } else {
                    throw "Error submitting transaction"
                }
            } else {
                throw "Error submitting transaction"
            }
        } catch {return TradeResponse.getNullResponse()}
    }
    
    static func getBalance(symbol: String) async -> Double? {
        let url = URL(string: exchangeParameters.getSymbolUrl)!
        let requestBody = HivePoolsBalanceRequest(account: "bionicpainter")
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        do {
            let jsonData = try jsonEncoder.encode(requestBody)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let (response, _) = try await URLSession.shared.data(for: request)
            return makeBalanceResponse(for: response, symbol: symbol)
        } catch {
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
    
    static func makeBalanceResponse(for data: Data, symbol: String) -> Double? {
        do {
            let response = try JSONDecoder().decode(HivePoolsBalanceResponse.self, from: data)
            if response.result.count > 0, let result = response.result.first(where: {$0.symbol == symbol}) {
                return Double(result.balance)
            } else {
                throw "Error submitting order"
            }
        } catch {
            return nil
        }
    }
}
