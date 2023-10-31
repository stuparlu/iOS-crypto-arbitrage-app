//
//  BinanceCodables.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 31.10.23..
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

struct BinanceBalanceResponse: Codable {
    let makerCommission: Int
    let takerCommission: Int
    let buyerCommission: Int
    let sellerCommission: Int
    let commissionRates: BinanceCommissionRates
    let canTrade: Bool
    let canWithdraw: Bool
    let canDeposit: Bool
    let brokered: Bool
    let requireSelfTradePrevention: Bool
    let preventSor: Bool
    let updateTime: Int
    let accountType: String
    let balances: [BinanceBalance]
    let permissions: [String]
    let uid: Int
}

struct BinanceCommissionRates: Codable {
    let maker: String
    let taker: String
    let buyer: String
    let seller: String
}

struct BinanceBalance: Codable {
    let asset: String
    let free: String
    let locked: String
}
