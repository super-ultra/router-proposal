import SwiftUI


struct ColorSetView: View {

    let colors: [Color]
    let router: ColorSetRouter

    var body: some View {
        List(colors, id: \.self) { color in
            Button(
                action: {
                    router.route(to: .color(color))
                },
                label: {
                    Text(color.description)
                }
            )
        }
        .navigationTitle("🎨 Colors")
    }

}

extension ColorSetView {

    private enum Static {
        static let creativeColors: [Color] = [
            .red,
            .gray,
            .green,
            .yellow
        ]
    }

    static func makeCreative(router: ColorSetRouter) -> Self {
        return ColorSetView(colors: Static.creativeColors, router: router)
    }

}
