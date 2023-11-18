//
//  KeychainManagerTest.swift
//  Crypto Arby Tests
//
//  Created by Luka Stupar on 18.11.23..
//

import XCTest
@testable import Crypto_Arby

final class KeychainManagerTest: XCTestCase {

    override func setUpWithError() throws {
        let manager = KeychainManager.shared
        manager.deleteConfiguration(for: "test")
    }

    override func tearDownWithError() throws {
        let manager = KeychainManager.shared
        manager.deleteConfiguration(for: "test")
    }

    func testSavingAndRetrieval() throws {
        let test = "test"
        let key = "key"
        let secret = "secret"
        
        let manager = KeychainManager.shared
        var result: ExchangeConfiguration? = manager.retriveConfiguration(forExchange: test)
        XCTAssertNil(result)
        let config = ExchangeConfiguration(apiKey: key, apiSecret: secret)
        manager.save(config, for: test)
        result = manager.retriveConfiguration(forExchange: test)
        XCTAssertEqual(result?.apiKey, key)
        XCTAssertEqual(result?.apiSecret, secret)
        manager.deleteConfiguration(for: test)
        result = manager.retriveConfiguration(forExchange: test)
        XCTAssertNil(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
