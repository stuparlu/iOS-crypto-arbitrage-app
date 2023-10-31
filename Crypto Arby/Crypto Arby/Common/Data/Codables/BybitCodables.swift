//
//  BybitCodables.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 30.10.23..
//

import Foundation

struct BybitMarketRequestBody: Codable {
    let category: String
    let symbol: String
    let side: String
    let orderType: String
    let qty: String
}

struct BybitMarketResponseBody: Codable {
    let result: BybitOrderId
    let retCode: Int
    let retExtInfo: [String: String]
    let retMsg: String
    let time: Int
}

struct BybitOrderId: Codable {
    let orderId: String
    let orderLinkId: Int
}

struct BybitBalanceResponseBody: Codable {
    let retCode: Int
    let retMsg: String
    let result: Result
    let retExtInfo: [String: String]
    let time: Int
}

struct Result: Codable {
    let list: [ResultList]
}

struct ResultList: Codable {
    let accountType: String
    let accountIMRate: String
    let accountMMRate: String
    let accountLTV: String
    let totalEquity: String
    let totalWalletBalance: String
    let totalMarginBalance: String
    let totalAvailableBalance: String
    let totalPerpUPL: String
    let totalInitialMargin: String
    let totalMaintenanceMargin: String
    let coin: [Coin]
}

struct Coin: Codable {
    let coin: String
    let equity: String
    let usdValue: String
    let walletBalance: String
    let free: String
    let locked: String
    let availableToWithdraw: String
    let availableToBorrow: String
    let borrowAmount: String
    let accruedInterest: String
    let totalOrderIM: String
    let totalPositionIM: String
    let totalPositionMM: String
    let unrealisedPnl: String
    let cumRealisedPnl: String
}

