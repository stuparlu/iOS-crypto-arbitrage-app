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
        do {
            let encoder = JSONEncoder()
            let encodedCredentials = try encoder.encode(configuration)
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: exchange,
                kSecValueData as String: encodedCredentials
            ]
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            print(status == errSecSuccess ? "Save success" : "Save failure")
        } catch {}
    }
    
    func save(privateKey: String, for wallet: String) {
        if let valueData = privateKey.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: wallet,
                kSecValueData as String: valueData
            ]
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            print(status == errSecSuccess ? "Save success" : "Save failure")
        }
    }
    
    func retriveConfiguration(forExchange exchange: String) -> ExchangeConfiguration? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: exchange,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            do {
                let decoder = JSONDecoder()
                let credentials = try decoder.decode(ExchangeConfiguration.self, from: retrievedData)
                return credentials
            } catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
        } else {
            return nil
        }
    }
    
    func retriveConfiguration(forWallet wallet: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: wallet,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    func deleteConfiguration(for exchange: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: exchange
        ]
        let status = SecItemDelete(query as CFDictionary)
        print(status == errSecSuccess ? "Delete success": "Delete failed")
    }
}
