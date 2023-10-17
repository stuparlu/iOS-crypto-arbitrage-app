//
//  KeychainManager.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 29.9.23..
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    
    func save(_ configuration: ExchangeConfiguration, for exchange: String) {
        let apiKey = configuration.apiKey
        let apiSecret = configuration.apiSecret
        let exchangeData = "\(apiKey)!\(apiSecret)".data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: exchange,
                                    kSecValueData as String: exchangeData]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            return print("save error")
        }
    }
    
    func retriveConfiguration(for exchange: String) -> ExchangeConfiguration? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: exchange,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue!]
        var retrivedData: AnyObject? = nil
        let _ = SecItemCopyMatching(query as CFDictionary, &retrivedData)
        guard let data = retrivedData as? Data else {return nil}
        guard let apiData = String(data: data, encoding: String.Encoding.utf8)?.split(separator: "!") else {return nil}
        let apiKey = String(apiData[0])
        let apiSecret = String(apiData[1])
        return ExchangeConfiguration(apiKey: apiKey, apiSecret: apiSecret)
    }
}
