//
//  HiveDexCodables.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct HiveDexPriceQuery: Codable {
    let symbol: String
}

struct HiveDexPriceParameters: Encodable {
    let contract = "market"
    let table: String
    let query: HiveDexPriceQuery
    
    init(symbol: String, side: TradeSide) {
        self.query = HiveDexPriceQuery(symbol: symbol)
        self.table = side == .buy ? "buyBook":"sellBook"
    }
}

struct HiveDexPriceRequest: Encodable {
    let jsonrpc: String = "2.0"
    let id: Int = 1
    let method: String = "find"
    let params: HiveDexPriceParameters
    
    init(symbol: String, side: TradeSide) {
        self.params = HiveDexPriceParameters(symbol: symbol, side: side)
    }
}

struct HiveDexPriceResponse: Decodable {
    let jsonrpc: String
    let id: Int
    let result: [HiveDexPriceResult]
}

struct HiveDexPriceResult: Decodable {
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

struct HiveDexMarketTradeRequest: Encodable {
    let contractName = "market"
    let contractAction: String
    let contractPayload : HiveDexMarketTradePayload
    
    init(symbol: String, data: OrderData) {
        self.contractAction = data.side == .buy ? "buy" : "sell"
        self.contractPayload = HiveDexMarketTradePayload(symbol: symbol, data: data)
        
    }
}

struct HiveDexMarketTradePayload: Encodable {
    let symbol: String
    let quantity: String
    let price: String
    
    init(symbol: String, data: OrderData) {
        self.symbol = symbol
        self.quantity = String(data.quantity)
        self.price = String(data.price)
    }
}

struct HiveDexBalanceRequest: Encodable {
    let jsonrpc = "2.0"
    let id = 1
    let method = "find"
    let params: HiveDexBalanceParameters
    
    init(account: String) {
        self.params = HiveDexBalanceParameters(account:account)
    }
}

struct HiveDexBalanceParameters: Encodable {
    let contract = "tokens"
    let table = "balances"
    let query: HiveDexBalanceQuery
    
    init(account: String) {
        self.query = HiveDexBalanceQuery(account:account)
        
    }
}

struct HiveDexBalanceQuery: Encodable {
    let account: String
}

struct HiveDexBalanceResponse: Decodable {
    let jsonrpc: String
    let id: Int
    let result: [HiveDexBalanceResult]
}

struct HiveDexBalanceResult: Codable {
    let id: Int
    let account: String
    let symbol: String
    let balance: String
    let stake: String
    let pendingUnstake: String
    let delegationsIn: String
    let delegationsOut: String
    let pendingUndelegations: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case account, symbol, balance, stake, pendingUnstake, delegationsIn, delegationsOut, pendingUndelegations
    }
}
