//
//  Bordcaster.swift
//  Howdy
//
//  Created by Dan Stoian on 03.11.2023.
//

import Foundation
import Network

class Advertiser {
    
    public static let shared  = Advertiser()
    
    private let listener: NWListener
    
    private(set) var connectionState: AdvertiserState = .disconnected
   
    private init() {
        
        guard let listener = try? NWListener(service: .init(name: "Howdy", type: "_zero._udp"), using: .udp) else {
            fatalError("Could not register Howdy as a Bonjour service")
        }
        
        self.listener = listener
        
        listener.stateUpdateHandler = { newState in
            switch newState {
            case.ready:
                self.connectionState = .connected
            default:
                self.connectionState = .disconnected
            }
        }
        
        listener.newConnectionHandler =  { newConnection in
            print("We have a client!")
        }
        
        listener.start(queue: .main)
    }
    
}
