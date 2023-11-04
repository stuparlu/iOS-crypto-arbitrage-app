//
//  Data.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 3.11.23..
//

import Foundation

extension Data {
    init?(hexString: String) {
        let string: String
        if hexString.hasPrefix("0x") {
            string = String(hexString.dropFirst(2))
        } else {
            string = hexString
        }

        guard string.count % 2 == 0 else { return nil }

        self.init(capacity: string.count / 2)

        var index = string.startIndex
        while index < string.endIndex {
            let byteString = string[index ..< string.index(index, offsetBy: 2)]
            if var num = UInt8(byteString, radix: 16) {
                self.append(&num, count: 1)
            } else {
                return nil
            }
            index = string.index(index, offsetBy: 2)
        }
    }
}
