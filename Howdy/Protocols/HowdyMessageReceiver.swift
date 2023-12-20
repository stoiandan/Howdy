

import Foundation


protocol HowdyMessageReceiver: AnyObject {
    func receive(_ howdyMessage: HowdyMessage)
}
