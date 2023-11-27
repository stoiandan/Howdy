//
//  HowdyMessageHeader.swift
//  Howdy
//
//  Created by Dan Stoian on 11.11.2023.
//

import Foundation



struct HowdyMessageHeader: Codable {
    let hostnameSize: UInt
    let ipV4Size: UInt
    
    
    init(hostnameSize: UInt, ipV4Size: UInt) {
        self.hostnameSize = hostnameSize
        self.ipV4Size = ipV4Size
    }
    
    init(_ buffer: UnsafeRawBufferPointer) {
        var tempHostnameSize: UInt = 0
        var tempIpV4Size: UInt = 0
        withUnsafeMutableBytes(of: &tempHostnameSize) { typePtr in
            typePtr.copyMemory(from: UnsafeRawBufferPointer(start: buffer.baseAddress!,
                                                            count: MemoryLayout<UInt>.size))
        }
        withUnsafeMutableBytes(of: &tempIpV4Size) { lengthPtr in
            lengthPtr.copyMemory(from: UnsafeRawBufferPointer(start: buffer.baseAddress!.advanced(by: MemoryLayout<UInt>.size),
                                                              count: MemoryLayout<UInt>.size))
        }
        hostnameSize = tempHostnameSize
        ipV4Size = tempIpV4Size
    }
    
    static var size: Int {
        return MemoryLayout<UInt>.size * 2
    }
    
    var encoded: Data {
        var hostnameSize = hostnameSize
        var ipV4Size = ipV4Size
        var data =  Data(bytes: &hostnameSize, count: MemoryLayout<UInt>.size)
        data.append(Data(bytes: &ipV4Size, count: MemoryLayout<UInt>.size))
        
        return data
    }
    
    var messageSize: UInt {
        hostnameSize + ipV4Size
    }
}
