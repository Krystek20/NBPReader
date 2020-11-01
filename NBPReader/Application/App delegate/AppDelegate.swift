import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    private var applicationCoordinator: ApplicationCoordinator?
    private var applicationLaunchConfigurator: ApplicationLaunchConfigurating = ApplicationLaunchConfigurator()

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard applicationLaunchConfigurator.canLoadInterface else { return true }
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator?.start()
        return true
    }
}
