//
//  ContentView.swift
//  Howdy
//
//  Created by Dan Stoian on 02.11.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(Advertiser.self) var advertiser
    @State var messageStore = MessageStore()
    
    var body: some View {
        HStack {

            VStack {
                StatusIndicator(state: advertiser.connectionState)
                    .onTapGesture {
                       advertiser.switchState()
                    }
                Spacer()

            }
            Table(messageStore.messages) {
                TableColumn("Machine Name", value: \.hostname)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
