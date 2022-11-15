import UIKit
import SwiftUI

final class MainViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        rootNavigationController = UINavigationController()
        navigator = ViewControllerNavigatorImpl(navigationController: rootNavigationController)

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        rootNavigationController = UINavigationController()
        navigator = ViewControllerNavigatorImpl(navigationController: rootNavigationController)

        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRootViewController()
    }

    // MARK: - Private

    private let rootNavigationController: UINavigationController
    private let navigator: ViewControllerNavigator

    private func setupRootViewController() {
        addChild(rootNavigationController)
        view.addSubview(rootNavigationController.view)
        rootNavigationController.view.frame = view.bounds
        rootNavigationController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootNavigationController.didMove(toParent: self)

        rootNavigationController.viewControllers = [makeRootScreen()]
    }

    private func makeRootScreen() -> UIViewController {
        let router = IdeaSetRouterImpl(navigator: navigator)
        let view = IdeaSetView(router: router)
        let viewController = UIHostingController(rootView: view)
        return viewController
    }
}
