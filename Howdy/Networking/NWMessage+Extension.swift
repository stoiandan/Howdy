//
//  NWMessage+Extension.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation
import Network

extension NWProtocolFramer.Message {

    convenience init(with howdyHeaderInfo: UInt) {
        self.init(definition: HowdyProtocol.definition)
        self["hostnameSize"] = howdyHeaderInfo
    }
    
    var hostnameSize: UInt {
        guard let size = self["hostnameSize"] as? UInt else {
            return 0
        }
        return size
    }
}
