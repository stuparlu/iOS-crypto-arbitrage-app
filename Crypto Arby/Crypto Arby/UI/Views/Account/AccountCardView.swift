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
        HStack{
            VStack {
                Text(loginManager.currentUser?.email ?? "")
            }
            Spacer()
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
