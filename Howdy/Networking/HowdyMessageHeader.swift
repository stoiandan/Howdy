//
//  HowdyMessageHeader.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation



struct HowdyMessageHeader: Codable {
    let hostnameSize: UInt
    
    init(hostnameSize: UInt) {
        self.hostnameSize = hostnameSize
    }
    
    init(_ buffer: UnsafeMutableRawBufferPointer) {
        var tempHostnameSize: UInt = 0
        withUnsafeMutableBytes(of: &tempHostnameSize) { typePtr in
            typePtr.copyMemory(from: UnsafeRawBufferPointer(start: buffer.baseAddress!,
                                                            count: MemoryLayout<UInt>.size))
        }
        hostnameSize = tempHostnameSize
    }
    
    static var size: Int {
        return MemoryLayout<UInt>.size
    }
    
    var encoded: Data {
        var hostnameSize = hostnameSize
        return Data(bytes: &hostnameSize, count: MemoryLayout<UInt>.size)
    }
}
