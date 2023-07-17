//
//  MainView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 17.7.23..
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TabView {
                Text("Opportunities")
                    .tabItem {
                        Image(systemName: "image")
                        Text("Opportunities")
                    }
                
                Text("Prices")
                    .tabItem {
                        Image(systemName: "image")
                        Text("Prices")
                    }
                
                Text("History")
                    .tabItem {
                        Image(systemName: "image")
                        Text("History")
                    }
                
                Text("Account")
                    .tabItem {
                        Image(systemName: "image")
                        Text("Account")
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
