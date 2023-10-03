//
//  AccountCardView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 3.10.23..
//

import SwiftUI

struct AccountCardView: View {
    @StateObject private var loginManager = LoginManager.shared
    var body: some View {
        VStack {
            Text(loginManager.currentUser?.displayName ?? "")
            Text(loginManager.currentUser?.email ?? "")
            Button {
                loginManager.logout()
            } label: {
                Text(StringKeys.logout)
            }
        }
    }
}

#Preview {
    AccountCardView()
}
