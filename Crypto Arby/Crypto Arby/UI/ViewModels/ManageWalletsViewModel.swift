//
//  ManageWalletsViewModel.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 31.10.23..
//

import Foundation

class ManageWalletsViewModel: ObservableObject {

    @Published var model = ManageWalletsModel()

    func manage(wallet: String) {
        clearData()
        model.currentWallet = wallet
        loadWalletData()
        model.showingPopover.toggle()
    }
    
    func clearData() {
        model.accountName = ""
        model.privateKeyText = ""
        model.currentWallet = ""
        model.walletDisabled = true
    }
    
    func clearAllData() {
        Exchanges.wallets.allNames.forEach { item in
            KeychainManager.shared.deleteConfiguration(for: item)
        }
    }
    func saveWalletData() {
        if model.privateKeyText == "" || model.accountName == "" {
            return
        }
        KeychainManager.shared.save(
            hiveConfiguration: HiveWalletConfiguration(accountName: model.accountName, activeKey: model.privateKeyText),
            for: model.currentWallet)
        model.walletDisabled = true
        clearData()
        model.showingPopover.toggle()
    }
    
    func loadWalletData() {
        if let configuration = KeychainManager.shared.retriveHiveConfiguration(forWallet: model.currentWallet) {
            model.accountName = configuration.accountName
            model.privateKeyText = configuration.activeKey
            if model.privateKeyText == "" {
                model.walletDisabled = true
            } else {
                model.walletDisabled = false
            }
        }
    }
    
    func deleteWalletData() {
        KeychainManager.shared.deleteConfiguration(for: model.currentWallet)
        model.showingPopover.toggle()
    }
    
    func close() {
        model.showingPopover.toggle()
    }
}
