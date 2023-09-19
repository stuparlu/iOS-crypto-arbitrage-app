//
//  PricesModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation

struct PricesModel {
    static func getPricesForTicker(ticker: String, delegate: Tradable) {
        getPricesForTickerAtExchange(exchange: ExchangeNames.binance, ticker: ticker, delegate: delegate)
        getPricesForTickerAtExchange(exchange: ExchangeNames.bybit, ticker: ticker, delegate: delegate)
        getPricesForTickerAtExchange(exchange: ExchangeNames.bitfinex, ticker: ticker, delegate: delegate)
}
        
    static func getPricesForTickerAtExchange(exchange: String, ticker: String, delegate: Tradable) {
        let url = URL(string: ExchangeNames.urlMapper.getExchangeURL(exchange: exchange, ticker: ticker))!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.parseResult(result: .failure(error), delegate: delegate)
                return
            }
            guard let data = data else {
                self.parseResult(result: .failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)), delegate: delegate)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let responseType = priceResponseMapper[exchange] {
                    if let priceResponse = try decoder.decode(responseType, from: data) as? PriceResponse {
                        self.parseResult(result: .success(priceResponse.fetchBidAskData(exchange: exchange, ticker: ticker)), delegate: delegate)
                    } else {
                        self.parseResult(result: .failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)), delegate: delegate)
                    }
                } else {
                    self.parseResult(result: .failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)), delegate: delegate)
                }
            } catch {
                self.parseResult(result: .failure(error), delegate: delegate)
            }
        }
        task.resume()
    }
    
    static func parseResult(result: Result<BidAskData, Error>, delegate:Tradable) {
        switch result {
        case .success(let bidAskData):
            DispatchQueue.main.async {
                delegate.addPrices(price: bidAskData)
            }
        case .failure(let error):
            print("\(ErrorStrings.errorFetchingPrice)\(error)")
        }
    }
}
