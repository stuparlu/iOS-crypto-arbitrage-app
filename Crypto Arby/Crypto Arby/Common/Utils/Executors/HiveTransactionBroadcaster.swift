//
//  HiveTransactionBroadcaster.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 4.11.23..
//

import Foundation
import Steem

struct HiveTransactionBroadcaster {
    static func broadCastTransaction(to node: URL, with jsonString: String) -> Steem.API.TransactionConfirmation? {
            let client = Client(address: node)
            let propertiesRequest = Steem.API.GetDynamicGlobalProperties()
        do {
            let propertiesResult = try client.sendSynchronous(propertiesRequest)
            let blockNumber = UInt16(propertiesResult!.headBlockNumber & 0xffff)
            let blockPrefix = propertiesResult!.headBlockId.prefix
            
            let accountConfiguration = KeychainManager.shared.retriveHiveConfiguration(forWallet: Exchanges.wallets.hive)
            guard let accountConfiguration = accountConfiguration else {
                throw "Error retrieving wallet configuration"
            }
            let activeKey = PrivateKey.init(accountConfiguration.activeKey)
            
            let operation = Steem.Operation.CustomJson(
                requiredAuths: [accountConfiguration.accountName],
                requiredPostingAuths: [],
                id: "ssc-mainnet-hive",
                json: JSONString.init(jsonString: jsonString))
            var transaction = Steem.Transaction.init(refBlockNum: blockNumber, refBlockPrefix: blockPrefix, expiration: Date().addingTimeInterval(60))
            transaction.append(operation: operation)
            let signedTransaction = try transaction.sign(usingKey: activeKey!)
            let transactionRequest = Steem.API.BroadcastTransaction(transaction: signedTransaction)
            return try client.sendSynchronous(transactionRequest)
        } catch {
            return nil
        }
    }
}
