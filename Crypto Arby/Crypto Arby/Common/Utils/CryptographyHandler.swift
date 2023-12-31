//
//  CryptographyHandler.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 20.10.23..
//

import Foundation
import CommonCrypto

struct CryptographyHandler {
    static func hmac256(key: String, data: String) -> String {
        let keyData = key.data(using: .utf8)!
        let messageData = data.data(using: .utf8)!

        var result = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), (keyData as NSData).bytes, keyData.count, (messageData as NSData).bytes, messageData.count, &result)

        let hmacData = Data(bytes: result, count: result.count)
        return hmacData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    static func hmac384(key: String, data: String) -> String {
        let keyData = key.data(using: .utf8)!
        let messageData = data.data(using: .utf8)!
        
        var result = [UInt8](repeating: 0, count: Int(CC_SHA384_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA384), (keyData as NSData).bytes, keyData.count, (messageData as NSData).bytes, messageData.count, &result)
        
        let hmacData = Data(bytes: result, count: result.count)
        return hmacData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    static func getCurrentUTCTimestampInMilliseconds() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let currentDateString = dateFormatter.string(from: currentDate)
        if let utcDate = dateFormatter.date(from: currentDateString) {
            return String(Int64(utcDate.timeIntervalSince1970 * 1000))
        } else {
            return "0"
        }
    }
}
