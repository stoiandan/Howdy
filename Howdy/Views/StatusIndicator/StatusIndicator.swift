//
//  StatusIndicator.swift
//  Howdy
//
//  Created by Dan Stoian on 10.11.2023.
//

import SwiftUI

struct StatusIndicator: View {
    let state: AdvertiserState
    var body: some View {
        VStack {
            Circle()
                .fill(state == .connected ? .green : .red)
                .frame(width: 50, height: 50)
            Text(state == .connected ? "Connected" : "Disconnected")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    StatusIndicator(state: .connected)
}

#Preview {
    StatusIndicator(state: .disconnected)
}
