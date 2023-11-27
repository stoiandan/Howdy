//
//  NWMessage+Extension.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation
import Network

extension NWProtocolFramer.Message {
    convenience init(with howdyHeaderInfo: (UInt,UInt)) {
        self.init(definition: HowdyProtocol.definition)
        self[HowdyProtocol.label] = HowdyMessageHeader(hostnameSize: howdyHeaderInfo.0, ipV4Size: howdyHeaderInfo.1)
    }
    
    var howdyMessage: HowdyMessageHeader {
        guard let message = self[HowdyProtocol.label] as? HowdyMessageHeader else {
            return HowdyMessageHeader(hostnameSize: 0, ipV4Size: 0)
        }
        return message
    }
}
