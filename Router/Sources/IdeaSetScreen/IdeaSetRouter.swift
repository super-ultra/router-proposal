import SwiftUI

enum IdeaSetDestination {
    case colors(next: ColorSetDestination? = nil)
}

protocol IdeaSetRouter {
    func route(to destination: IdeaSetDestination)
    func routeActions(for destination: IdeaSetDestination) -> [NavigationAction]
}

final class IdeaSetRouterImpl: IdeaSetRouter {

    init(navigator: ViewControllerNavigator) {
        self.navigator = navigator
    }

    func route(to destination: IdeaSetDestination) {
        navigator.perform(routeActions(for: destination), animated: true)
    }

    func routeActions(for destination: IdeaSetDestination) -> [NavigationAction] {
        switch destination {
        case .colors(let next):
            let router = ColorSetRouterImpl(navigator: navigator)
            let view = ColorSetView.makeCreative(router: router)

            return [.push(view)] + (next.map { router.routeActions(for: $0) } ?? [])
        }
    }

    private let navigator: ViewControllerNavigator

}
