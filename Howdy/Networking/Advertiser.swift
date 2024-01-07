//
//  Bordcaster.swift
//  Howdy
//
//  Created by Dan Stoian on 03.11.2023.
//

import Foundation
import Network


@Observable
class Advertiser {
    
    public static let shared  = Advertiser()
    
    private let listener: NWListener
    
    private var connections: [HowdyConnection] = []
    
    private(set) var connectionState: AdvertiserState = .disconnected
    
    public weak var howdyMessageReceiverDelegate: HowdyMessageReceiver? = nil
   
    private init() {
        let udpWithHowdy = NWParameters.udp
        
        let howdyProtocol = NWProtocolFramer.Options(definition: HowdyProtocol.definition)
        
        udpWithHowdy.defaultProtocolStack.applicationProtocols.insert(howdyProtocol, at: 0)
        
        
        guard let listener = try? NWListener(service: .init(name: "Howdy", type: "_zero._udp"), using: udpWithHowdy) else {
            fatalError("Could not register Howdy as a Bonjour service")
        }
        
        
        self.listener = listener
    }
    
    public func start() {
        listener.stateUpdateHandler = { newState in
            switch newState {
            case.ready:
                self.connectionState = .connected
            default:
                self.connectionState = .disconnected
            }
        }
        
        listener.newConnectionHandler =  self.handleNewConnection
        
        listener.start(queue: .main)
    }
    
    
    private func handleNewConnection(_ newConnection: NWConnection) {
        print("We have a client!")
        let howdyConn = HowdyConnection(newConnection)
        howdyConn.receiver = howdyMessageReceiverDelegate
        connections.append(howdyConn)
    }
    
    public func switchState() {
        if connectionState == .connected {
            listener.queue?.suspend()
        } else {
            listener.queue?.resume()
        }
        
        connectionState = connectionState.swtichState()
    }
    
}
