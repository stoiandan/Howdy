//
//  StatusIndicatiorViewModel.swift
//  Howdy
//
//  Created by Dan Stoian on 01.12.2023.
//

import Foundation
import Observation


@Observable
class MessageStore: HowdyMessageReceiver {
    func receive(_ howdyMessage: HowdyMessage) {
        messages.append(howdyMessage)
    }
    
    private(set) var messages: [HowdyMessage] = []
    
    
    init() {
        Advertiser.shared.howdyMessageReceiverDelegate = self
    }
    
    
}
