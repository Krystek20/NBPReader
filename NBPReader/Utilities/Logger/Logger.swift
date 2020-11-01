import Foundation

protocol Logging {
    func log(_ string: String)
}

final class Logger: Logging {

    func log(_ string: String) {
        #if DEBUG
            print(string)
        #endif
    }
}
