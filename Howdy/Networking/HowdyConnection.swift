import Foundation
import Network


class HowdyConnection {
    
    private let connection: NWConnection
    
    public var receiver: HowdyMessageReceiver? = nil
    
    init(_ connection: NWConnection) {
        self.connection = connection
        
        start()
    }
    
    
    private func start() {
        self.connection.stateUpdateHandler = { [weak self] newState in
            guard let self = self else {
                return
            }
            switch newState {
            case .ready:
                print("\(self.connection) is ready!")
                receiveNextMessage()
            default:
                break
            }
        }
        
        self.connection.start(queue: .main)
    }
    
    
    private func receiveNextMessage() {
        connection.receiveMessage { dataContent, context, isComplete, err in
            guard let data = dataContent else {
                return
            }
            
            let string = String(data: data, encoding: .utf8)!
            let howdyMessage = HowdyMessage(hostname: string)
            print("We received data: \(howdyMessage.hostname)")
            self.receiver?.receive(howdyMessage)
            self.receiveNextMessage()
        }
    }
}
