//
//  HowdyMessage.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation
import Network


struct HowdyMessage: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let hostname: String
}
