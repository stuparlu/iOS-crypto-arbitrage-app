//
//  HiveDexRequestHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 1.11.23..
//

import Foundation

struct HiveDexPriceQuery: Codable {
    let symbol: String
}

struct HiveDexPriceParameters: Codable {
    var contract = "market"
    let table: String
    let query: HiveDexPriceQuery
    
    init(symbol: String, side: TradeSide) {
        self.query = HiveDexPriceQuery(symbol: symbol)
        self.table = side == .buy ? "buyBook":"sellBook"
    }
}

struct HiveDexPriceRequest: Codable {
    var jsonrpc: String = "2.0"
    var id: Int = 1
    var method: String = "find"
    let params: HiveDexPriceParameters
    
    init(symbol: String, side: TradeSide) {
        self.params = HiveDexPriceParameters(symbol: symbol, side: side)
    }
}

struct HiveDexPriceResponse: Codable {
    let jsonrpc: String
    let id: Int
    let result: [HiveDexPriceResult]
}

struct HiveDexPriceResult: Codable {
    let id: Int
    let txId: String
    let timestamp: Int
    let account: String
    let symbol: String
    let quantity: String
    let price: String
    let tokensLocked: String
    let expiration: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case txId
        case timestamp
        case account
        case symbol
        case quantity
        case price
        case tokensLocked
        case expiration
    }
}

struct HiveDexMarketTradeRequest: Codable {
    var jsonrpc: String = "2.0"
    var id: Int = 1
    var contract = "market"
    
    let params: HiveDexMarketTradeParameters
    
    init(symbol: String, data: OrderData) {
        self.params = HiveDexMarketTradeParameters(symbol: symbol, data: data)
    }
}

struct HiveDexMarketTradeParameters: Codable {
    var contractName = "market"
    var contractAction: String
    let contractPayload : HiveDexMarketTradePayload
    var account = "@bionicpainter"
    var privateKey = KeychainManager.shared.retriveConfiguration(forWallet: Exchanges.wallets.hive)
    
    init(symbol: String, data: OrderData) {
        self.contractAction = data.side == .buy ? "buy" : "sell"
        self.contractPayload = HiveDexMarketTradePayload(symbol: symbol, data: data)
        
    }
}

struct HiveDexMarketTradePayload: Codable {
    let symbol: String
    let quantity: String
    let price: String
    
    init(symbol: String, data: OrderData) {
        self.symbol = symbol
        self.quantity = String(data.quantity)
        self.price = String(data.price)
    }
}

struct HiveDexRequestHandler {
    static let exchangeParameters = Exchanges.parameters.hiveDex
    
    static func getBidAskData(for ticker: String) async -> BidAskData? {
        let exchangePairName = Cryptocurrencies.findPair(by: ticker).mainSymbol
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
    
    static func submitTradeOrder(orderData: OrderData) async -> TradeResponse {
        do {
            let exchangePairName = Cryptocurrencies.findPair(by: orderData.symbol).mainSymbol
            if let url = URL(string: exchangeParameters.getSymbolUrl) {
                let body = HiveDexMarketTradeRequest(symbol: exchangePairName, data: orderData)
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .sortedKeys
                let jsonData = try! jsonEncoder.encode(body)
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                let (response, _) = try await URLSession.shared.data(for: request)
                if let dataString = String(data: response, encoding: .utf8) {
                    print(dataString)
                }
                return makeTradeResponse(for: response)
            }
            else {
                throw "Error submitting order"
            }
        } catch {return TradeResponse.getNullResponse()}
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
}
