import Foundation
import Network


class Browser {
    
    private let encoder = JSONEncoder()
    
    private let browser: NWBrowser
    
    init() {
        let howdyDescriptor: NWBrowser.Descriptor = .bonjour(type: "_zero._udp", domain: ".local")
        
        let params: NWParameters = .udp
        
        
        let howdyProtocol = NWProtocolFramer.Options(definition: HowdyProtocol.definition)
        
        params.defaultProtocolStack.applicationProtocols.insert(howdyProtocol, at: 0)
        
        let browser = NWBrowser(for: howdyDescriptor, using: params)
        
        self.browser = browser
        
        browser.browseResultsChangedHandler = { [unowned self] results, changes in
            
            for result in results {
                let conn = NWConnection(to: result.endpoint, using: params)
                let procInfo = ProcessInfo()
                let thisPCMessage = HowdyMessage(hostname: procInfo.hostName )
                let data = try! encoder.encode(thisPCMessage)
                conn.send(content: data, completion: .idempotent)
            }
        }
    }
}
