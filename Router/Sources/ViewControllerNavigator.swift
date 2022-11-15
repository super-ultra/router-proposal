import UIKit
import SwiftUI


protocol ViewControllerNavigator {
    func push(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool)
}


extension ViewControllerNavigator {
    func push<V: View>(_ view: V, animated: Bool) {
        push(UIHostingController(rootView: view), animated: animated)
    }
}


final class ViewControllerNavigatorImpl: ViewControllerNavigator {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController?.present(viewController, animated: animated)
    }

    // MARK: - Private

    private weak var navigationController: UINavigationController?

}
