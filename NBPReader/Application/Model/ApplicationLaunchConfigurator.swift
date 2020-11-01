import Foundation

protocol ApplicationLaunchConfigurating {
    var canLoadInterface: Bool { get }
}

final class ApplicationLaunchConfigurator: ApplicationLaunchConfigurating {

    var canLoadInterface: Bool {
        !Self.isRunningTests
    }

    private static var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}

