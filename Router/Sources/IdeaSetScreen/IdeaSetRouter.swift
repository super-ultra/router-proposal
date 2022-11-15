import SwiftUI

enum IdeaSetDestination {
    case colors(next: ColorSetDestination? = nil)
}

protocol IdeaSetRouter {
    func route(to destination: IdeaSetDestination)
}

final class IdeaSetRouterImpl: IdeaSetRouter {

    init(navigator: ViewControllerNavigator) {
        self.navigator = navigator
    }

    func route(to destination: IdeaSetDestination) {
        switch destination {
        case .colors(let next):
            let router = ColorSetRouterImpl(navigator: navigator)
            let view = ColorSetView.makeCreative(router: router)
            self.navigator.push(view, animated: true)

            if let next = next {
                router.route(to: next)
            }
        }
    }

    private let navigator: ViewControllerNavigator

}
