//
//  HowdyProtocol.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation
import Network


class HowdyProtocol: NWProtocolFramerImplementation {
    
    static let definition = NWProtocolFramer.Definition(implementation: HowdyProtocol.self)
    
    static var label = "HowdyProtocol"
    
    required init(framer: NWProtocolFramer.Instance) {
        
    }
    
    func start(framer: NWProtocolFramer.Instance) -> NWProtocolFramer.StartResult {
        return .ready
    }
    // return how many bytes are still neded
    func handleInput(framer: NWProtocolFramer.Instance) -> Int {
        while true {
            var tmpHeader: HowdyMessageHeader? = nil
            let headerSize = HowdyMessageHeader.size
            
            let parserd = framer.parseInput(minimumIncompleteLength: headerSize, maximumLength: headerSize) {
                // return how many bytes from the needed min and max were processed
                (buffer: UnsafeMutableRawBufferPointer?, isDone: Bool) in
                
                // if we don't have a buffer, we still need to process all bytes
                guard let buffer = buffer else {
                    return 0
                }
                
                // buffer is not completed, can't really process anything
                if buffer.count < headerSize {
                    return 0
                }
                
                tmpHeader = HowdyMessageHeader(UnsafeRawBufferPointer(buffer))
                
                return headerSize
            }
            
            guard parserd, let header = tmpHeader else {
                return headerSize
            }
            
            
          
            let message =  NWProtocolFramer.Message(with: (header.hostnameSize, header.ipV4Size))
          
            
            if !framer.deliverInputNoCopy(length: Int(header.messageSize), message: message, isComplete: true) {
                return 0
            }
            
        }
    }
    
    func handleOutput(framer: NWProtocolFramer.Instance,
                      message: NWProtocolFramer.Message,
                      messageLength: Int,
                      isComplete: Bool) {
        
        let header = message.howdyMessage
        
        framer.writeOutput(data: header.encoded)
        
        // Ask the connection to insert the content of the app message after your header.
        do {
            try framer.writeOutputNoCopy(length: messageLength)
        } catch let error {
            print("Hit error writing \(error)")
        }
    }
    
    func wakeup(framer: NWProtocolFramer.Instance) {
        
    }
    
    func stop(framer: NWProtocolFramer.Instance) -> Bool {
        return true
    }
    
    func cleanup(framer: NWProtocolFramer.Instance) {
        
    }
    
    
}
