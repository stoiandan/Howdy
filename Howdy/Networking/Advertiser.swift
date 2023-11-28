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
    
    private(set) var connectionState: AdvertiserState = .disconnected
    
    public var howdyMessageReceiverDelegate: HowdyMessageReceiver? = nil
   
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
        newConnection.receiveMessage { data, context, isDone, error in
            guard error == nil, let data = data else {
                return
            }
            
            guard let message = context?.protocolMetadata(definition: HowdyProtocol.definition) as? NWProtocolFramer.Message else {
                return
            }
            
            let header = message.howdyMessage
            
            let hostName = String(decoding: data[...Int(header.hostnameSize)], as: UTF8.self)
            
            let ipV4 = String(decoding: data[(Int(header.hostnameSize)+1)...], as: UTF8.self)
            
            let howdyMessage = HowdyMessage(hostname: hostName, ipv4: .init(ipV4)! )
            
            self.howdyMessageReceiverDelegate?.receive(howdyMessage)
        }
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
