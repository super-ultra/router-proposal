import UIKit
import SwiftUI

enum NavigationAction {
    case push(UIViewController)
    case present(UIViewController)

    static func push<V: View>(_ view: V) -> Self {
        return .push(UIHostingController(rootView: view))
    }
}

// ПОЛУЧШЕ
//struct NavigationAction {
//    enum ActionType {
//        case push
//        case present
//    }
//    var type: ActionType
//    var viewController: UIViewController
//}


protocol ViewControllerNavigator {
    func perform(_ actions: [NavigationAction], animated: Bool)
}

extension ViewControllerNavigator {

    func push(_ viewController: UIViewController, animated: Bool) {
        perform([.push(viewController)], animated: animated)
    }

    func present(_ viewController: UIViewController, animated: Bool) {
        perform([.present(viewController)], animated: animated)
    }

}

extension ViewControllerNavigator {
    func push<V: View>(_ view: V, animated: Bool) {
        push(UIHostingController(rootView: view), animated: animated)
    }
}


// MARK: - Impl

final class ViewControllerNavigatorImpl: ViewControllerNavigator {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func perform(_ actions: [NavigationAction], animated: Bool) {
        guard let navigationController else { return  }

        let chunks = makeChunks(for: actions)
        for chunk in chunks {
            switch chunk {
            case .present(let viewControllers):
                for vc in viewControllers {
                    navigationController.present(vc, animated: animated)
                }
            case .push(let viewControllers):
                navigationController.setViewControllers(
                    navigationController.viewControllers + viewControllers,
                    animated: animated
                )
            }
        }
    }

    // MARK: - Private

    enum NavigationChunkAction {
        case push([UIViewController])
        case present([UIViewController])

        mutating func append(_ viewController: UIViewController) {
            switch self {
            case .present(let viewControllers):
                self = .present(viewControllers + [viewController])
            case .push(let viewControllers):
                self = .push(viewControllers + [viewController])
            }
        }
    }

    private weak var navigationController: UINavigationController?

    private func makeChunks(for actions: [NavigationAction]) -> [NavigationChunkAction] {
        var currentChunk: NavigationChunkAction?
        var result: [NavigationChunkAction] = []

        for action in actions {
            switch (action, currentChunk) {
            case (.push(let vc), .push):
                currentChunk?.append(vc)

            case (.present(let vc), .present):
                currentChunk?.append(vc)

            case (.push(let vc), _):
                if let currentChunk {
                    result.append(currentChunk)
                }
                currentChunk = .push([vc])

            case (.present(let vc), _):
                if let currentChunk {
                    result.append(currentChunk)
                }
                currentChunk = .present([vc])
            }
        }

        if let currentChunk {
            result.append(currentChunk)
        }

        return result
    }

}
