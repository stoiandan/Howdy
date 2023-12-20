//
//  ContentView.swift
//  Howdy
//
//  Created by Dan Stoian on 02.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State var advertiser = Advertiser.shared
    @State var messages = MessagesViewModel()
    
    var body: some View {
        HStack {

            VStack {
                StatusIndicator(state: advertiser.connectionState)
                    .onTapGesture {
                       advertiser.switchState()
                    }
                ForEach(messages.machines, id: \.self) { machine  in
                    Text(machine.hostname)
                }
                Spacer()

            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
