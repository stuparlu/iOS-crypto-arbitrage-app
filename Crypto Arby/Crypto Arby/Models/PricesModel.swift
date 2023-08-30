//
//  PricesModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 19.7.23..
//

import Foundation

class PricesModel {
    func getPricesForTicker(ticker: String, delegate: PricesViewViewModel) {
        getPricesForTickerAtExchange(exchange: ExchangeNames.binance, ticker: ticker) { result in
            self.parseResult(result: result, delegate:delegate)
        }
        getPricesForTickerAtExchange(exchange: ExchangeNames.bybit, ticker: ticker) { result in
            self.parseResult(result: result, delegate:delegate)
        }
        getPricesForTickerAtExchange(exchange: ExchangeNames.bitfinex, ticker: ticker) { result in
            self.parseResult(result: result, delegate:delegate)
        }
}
        
    func getPricesForTickerAtExchange(exchange: String, ticker: String, completion: @escaping (Result<BidAskData, Error>) -> Void) {
        let url = URL(string: ExchangeNames.urlMapper.getExchangeURL(exchange: exchange, ticker: ticker))!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let responseType = priceResponseMapper[exchange] {
                    if let priceResponse = try decoder.decode(responseType, from: data) as? PriceResponse {
                        completion(.success(priceResponse.fetchBidAskData(exchange: exchange, ticker: ticker)))
                    } else {
                        completion(.failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)))
                    }
                } else {
                    completion(.failure(NSError(domain: StringKeys.empty_string, code: 0, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func parseResult(result: Result<BidAskData, Error>, delegate:PricesViewViewModel) {
        switch result {
        case .success(let bidAskData):
            DispatchQueue.main.async {
                delegate.exchangePrices.append(bidAskData)
            }
        case .failure(let error):
            print("\(ErrorStrings.errorFetchingPrice)\(error)")
        }
    }
}
