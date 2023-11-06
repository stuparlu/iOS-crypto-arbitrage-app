//
//  HiveDexRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 1.11.23..
//

import Foundation
import Steem

struct HiveDexRequestHandler: RequestHandler {
    static var exchangeParameters: ExchangeParameters = Exchanges.parameters.hiveDex
    
    static func getBidAskData(for ticker: String) async -> BidAskData? {
        let pair = Cryptocurrencies.findPair(by: ticker)
        let exchangePairName = pair.mainSymbol
        if pair.quoteSymbol != "SWAP.HIVE" {
            return nil
        }
        let url = URL(string: exchangeParameters.getSymbolUrl)!
        let buyBody = HiveDexPriceRequest(symbol: exchangePairName, side: .buy)
        let sellBody = HiveDexPriceRequest(symbol: exchangePairName, side: .buy)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .sortedKeys
        let buyData = try! jsonEncoder.encode(buyBody)
        let sellData = try! jsonEncoder.encode(sellBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = buyData
        do {
            let (buyResponse, _) = try await URLSession.shared.data(for: request)
            request.httpBody = sellData
            let (sellResponse, _) = try await URLSession.shared.data(for: request)
            return makeBidAskResponseFor(symbol: ticker, buyData: buyResponse, sellData: sellResponse)
        }
        catch {
            DispatchQueue.main.async {
                print("Error retrieving data for \(ticker) at \(exchangeParameters.name.capitalized): \(error)")
            }
            return nil
        }
    }
    
    static func submitTradeOrder(with orderData: OrderData) async -> TradeResponse {
        do {
            let exchangePairName = Cryptocurrencies.findPair(by: orderData.symbol).mainSymbol
            let requestBody = HiveDexMarketTradeRequest(symbol: exchangePairName, data: orderData)
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
        let requestBody = HiveDexBalanceRequest(account: "bionicpainter")
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
    
    static func makeBidAskResponseFor(symbol: String, buyData: Data, sellData: Data) -> BidAskData? {
        do {
            let buyBook = try JSONDecoder().decode(HiveDexPriceResponse.self, from: buyData)
            let sellBook = try JSONDecoder().decode(HiveDexPriceResponse.self, from: sellData)
            if buyBook.result.count > 0 && sellBook.result.count > 0 {
                let buyResult = buyBook.result[0]
                let sellResult = sellBook.result[0]
                if let buyPrice = Double(buyResult.price), let buyQuantity = Double(buyResult.quantity),
                   let sellprice = Double(sellResult.price), let sellQuantity = Double(sellResult.quantity) {
                    return BidAskData(exchange: exchangeParameters.name, symbol: symbol, bidPrice: sellprice, askPrice: buyPrice, bidQuantity: sellQuantity, askQuantity: buyQuantity)
                } else {
                    throw "Error getting Bid/Ask data."
                }
            } else {
                throw "Error getting Bid/Ask data."
            }
        } catch {
            return nil
        }
    }
    
    static func makeBalanceResponse(for data: Data, symbol: String) -> Double? {
        do {
            let response = try JSONDecoder().decode(HiveDexBalanceResponse.self, from: data)
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
