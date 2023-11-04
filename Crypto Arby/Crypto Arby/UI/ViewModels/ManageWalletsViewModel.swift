//
//  ManageWalletsViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 31.10.23..
//

import Foundation

class ManageWalletsViewModel: ObservableObject {
    @Published var showingPopover = false
    @Published var accountName = ""
    @Published var privateKeyText = ""
    @Published var walletDisabled = false
    var currentWallet = ""

    func manage(wallet: String) {
        clearData()
        currentWallet = wallet
        loadWalletData()
        showingPopover.toggle()
    }
    
    func clearData() {
        accountName = ""
        privateKeyText = ""
        currentWallet = ""
        walletDisabled = true
    }
    
    func clearAllData() {
        Exchanges.wallets.allNames.forEach { item in
            KeychainManager.shared.deleteConfiguration(for: item)
        }
    }
    func saveWalletData() {
        if privateKeyText == "" || accountName == "" {
            return
        }
        KeychainManager.shared.save(
            hiveConfiguration: HiveWalletConfiguration(accountName: accountName, activeKey: privateKeyText),
            for: currentWallet)
        walletDisabled = true
        clearData()
        showingPopover.toggle()
    }
    
    func loadWalletData() {
        if let configuration = KeychainManager.shared.retriveHiveConfiguration(forWallet: currentWallet) {
            accountName = configuration.accountName
            privateKeyText = configuration.activeKey
            if privateKeyText == "" {
                walletDisabled = true
            } else {
                walletDisabled = false
            }
        }
    }
    
    func deleteWalletData() {
        KeychainManager.shared.deleteConfiguration(for: currentWallet)
        showingPopover.toggle()
    }
}
