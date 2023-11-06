# iOS Cryptocurrency Arbitrage App

## About The Project

This is a university project application with a goal of finding arbitrage in cryptocurrency markets using an iOS device. Since most of crypto arbitrage applications give users results late, and non-flexible monitoring mechanisms, I have decided to take different approach.

This application doesn't rely on external sources of data, but polls exchanges directly for user-selected pairs of cryptocurrencies.

Since this is a proof-of-concept application. Please understand that you use this at your own risk. I am not responisble for any financial gains or losses incurred due to usage.

### Built With
The project was built using these libraries and technologies

- [Swift](https://developer.apple.com/swift/)
- [CoreData](https://developer.apple.com/documentation/coredata/)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Swift-hive](https://github.com/hiveuprss/swift-hive)

## Getting Started
### Prerequisites
In order to get started please make sure that you either have a device that supports iOS 16.4 or higher and a Mac that can build applications for iOS 16.4.

### Precaution
 Since I have not uploaded this app to the AppStore, please refer to sideloading application at your own risk.
Application stores all data locally including API and wallet keys. It does not transmit them online.

## Usage

This application can detect cross exchange arbitrage as well as circular arbitrage
Currently it supports:
 - Binance
 - Bybit
 - Bitfinex
 - Dex and liquidity pools on Hive engine
 
Use of application is divided into few parts.
First is display of bid/ask prices for a particular coin. Application also notifies users of new arbitrage opportunities if configured to do so. In order to configure those, user can choose to monitor cross exchange opportunities and/or circular opportunities on a single exchange in the "opportunities" view.

During the configuration user can opt in to automatically trade opportunities that were found. This requires that user has previously entered his API keys in the exchange and wallet management options in the "Account" tab. Should a trade fail, the application will stop trading for the configured opportunity.
 Please note that at this time, generating wallets is not available, so user has to link an existing wallet. 

Current variety of cryptocurrencies is limited. If the project continues to develop, more options will be added.

## License
This code comes under no license, you can use it as you please, but at your own risk.
This application comes under no warranty, and any damage or financial losses are your own responisbility.

## Contact
Luka Stupar - [Linkedin](https://twitter.com/your_username) - stuparbluka@protonmail.com

Project Link: [https://github.com/stuparlu/iOS-crypto-arbitrage-app/](https://github.com/stuparlu/iOS-crypto-arbitrage-app/)
