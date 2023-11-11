//
//  AdvertiserState.swift
//  Howdy
//
//  Created by Dan Stoian on 10.11.2023.
//

import Foundation


enum AdvertiserState {
    case connected
    case disconnected
    
    
    func swtichState() -> Self {
        self == .connected ? .disconnected : .connected
    }
}
