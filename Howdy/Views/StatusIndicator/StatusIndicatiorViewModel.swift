//
//  StatusIndicatiorViewModel.swift
//  Howdy
//
//  Created by Dan Stoian on 01.12.2023.
//

import Foundation
import Observation


@Observable
class MessagesViewModel: HowdyMessageReceiver {
    func receive(_ howdyMessage: HowdyMessage) {
        machines.append(howdyMessage)
    }
    
    private(set) var machines: [HowdyMessage] = []
    
    
    init() {
        Advertiser.shared.howdyMessageReceiverDelegate = self
    }
    
    
}
