//
//  HowdyApp.swift
//  Howdy
//
//  Created by Dan Stoian on 02.11.2023.
//

import SwiftUI

@main
struct HowdyApp: App {
    
    let advertiser = Advertiser.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(advertiser)
        }

    }
}
