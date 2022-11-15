import SwiftUI

enum ColorSetDestination {
    case color(Color)
}

protocol ColorSetRouter {
    func route(to destination: ColorSetDestination)
}

final class ColorSetRouterImpl: ColorSetRouter {

    init(navigator: ViewControllerNavigator) {
        self.navigator = navigator
    }

    func route(to destination: ColorSetDestination) {
        switch destination {
        case .color(let color):
            let view = ColorView(color: color)
            let vc = UIHostingController(rootView: view)
            self.navigator.push(vc, animated: true)
        }
    }

    private let navigator: ViewControllerNavigator

}
