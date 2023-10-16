//
//  LoadingIndicatorView.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 16.10.23..
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var degrees: Double = 0
    var body: some View {
        Spacer()
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(ThemeManager.accentColor, lineWidth: 5)
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: degrees))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    self.degrees = 360
                }
            }
        Spacer()
    }

}

#Preview {
    LoadingIndicatorView()
}
