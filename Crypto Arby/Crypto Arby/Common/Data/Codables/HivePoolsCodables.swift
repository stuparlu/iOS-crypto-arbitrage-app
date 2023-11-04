//
//  HivePoolsCodables.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation

struct HivePoolsPriceRequest: Encodable {
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

struct HivePoolsPriceParameters: Encodable {
    let contract = "marketpools"
    let table = "pools"
    let query: HivePoolsPriceQuery
    
    init(pair: String) {
        self.query = HivePoolsPriceQuery(tokenPair: pair)
    }
}

struct HivePoolsPriceQuery: Encodable {
    let tokenPair: String
}

struct HivePoolsPriceResponse: Decodable {
    let jsonrpc: String
    let id: Int
    let result: [HivePoolsPriceResult]
}

struct HivePoolsPriceResult : Decodable {
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

struct HivePoolsMarketTradeRequest: Encodable {
    let contractName = "marketPools"
    let contractAction = "swapTokens"
    let contractPayload : HivePoolsMarketTradePayload
    
    init(symbol: CurrencyPair, data: OrderData) {
        self.contractPayload = HivePoolsMarketTradePayload(symbol: symbol, data: data)
    }
}

struct HivePoolsMarketTradePayload: Encodable {
    let tokenPair: String
    let tokenSymbol: String
    let tokenAmount: String
    let tradeType = "exactInput"
    let minAmountOut: String
    
    init(symbol: CurrencyPair, data: OrderData) {
        self.tokenPair = Exchanges.mapper.getSearchableName(for: symbol, at: Exchanges.names.hivePools)
        self.tokenSymbol = symbol.quoteSymbol
        self.tokenAmount = String(data.quantity * data.price)
        self.minAmountOut = String(data.quantity.decreaseByPercent(0.5))
    }
}

struct HivePoolsBalanceRequest: Encodable {
    let jsonrpc = "2.0"
    let id = 1
    let method = "find"
    let params: HivePoolsBalanceParameters
    
    init(account: String) {
        self.params = HivePoolsBalanceParameters(account:account)
    }
}

struct HivePoolsBalanceParameters: Encodable {
    let contract = "tokens"
    let table = "balances"
    let query: HivePoolsBalanceQuery
    
    init(account: String) {
        self.query = HivePoolsBalanceQuery(account:account)
        
    }
}

struct HivePoolsBalanceQuery: Encodable {
    let account: String
}

struct HivePoolsBalanceResponse: Decodable {
    let jsonrpc: String
    let id: Int
    let result: [HivePoolsBalanceResult]
}

struct HivePoolsBalanceResult: Codable {
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
