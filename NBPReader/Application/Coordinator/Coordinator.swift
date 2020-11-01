import Foundation

protocol Coordinating {
    var identifier: UUID { get }
    func navigate(to coordinator: Coordinating)
    func start()
}

class Coordinator: Coordinating {

    // MARK: - Properties

    var identifier = UUID()
    private var coordinators = [UUID: Coordinating]()
    private let logger: Logging

    // MARK: - Initialization

    init(logger: Logging = Logger()) {
        self.logger = logger
    }

    // MARK: - Managing

    func start() {
        logger.log("Coordinator started: \(Self.self) identifier: \(identifier)")
    }

    func navigate(to coordinator: Coordinating) {
        coordinators[coordinator.identifier] = coordinator
        coordinator.start()
    }

    func remove(_ coordinator: Coordinating) {
        coordinators[coordinator.identifier] = nil
        logger.log("Coordinator removed: \(coordinator.self) identifier: \(coordinator.identifier)")
    }
}
