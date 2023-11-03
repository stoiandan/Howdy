//
//  Bordcaster.swift
//  Howdy
//
//  Created by Dan Stoian on 03.11.2023.
//

import Foundation
import Network

class Multicaster {
    
    public static let shared  = Multicaster()
    
    private let listener: NWListener
    
    private(set) var connectionState = "Disconnected"
   
    private init?() {
        
        guard let listener = try? NWListener(service: .init(name: "Howdy", type: "_zero._udp"), using: .udp) else {
            fatalError("Could not register Howdy as a Bonjour service")
        }
        
        self.listener = listener
        
        listener.stateUpdateHandler = { newState in
            switch newState {
            case.ready:
                print("starting")
            case .failed(let error):
                print("error: \(error)")
            default:
                print(newState)
            }
        }
        
        listener.newConnectionHandler =  { newConnection in
            print("We have a client!")
        }
        
        listener.start(queue: .main)
    }
    
}
