import SwiftUI

enum ColorSetDestination {
    case color(Color)
}

protocol ColorSetRouter {
    func route(to destination: ColorSetDestination)
    func routeActions(for destination: ColorSetDestination) -> [NavigationAction]
}

final class ColorSetRouterImpl: ColorSetRouter {

    init(navigator: ViewControllerNavigator) {
        self.navigator = navigator
    }

    func route(to destination: ColorSetDestination) {
        navigator.perform(routeActions(for: destination), animated: true)
    }

    func routeActions(for destination: ColorSetDestination) -> [NavigationAction] {
        switch destination {
        case .color(let color):
            let view = ColorView(color: color)
            return [.push(view)]
        }
    }

    private let navigator: ViewControllerNavigator

}
