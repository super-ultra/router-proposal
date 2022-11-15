import SwiftUI


struct IdeaSetView: View {

    let router: IdeaSetRouter

    var body: some View {
        List {
            Button("Colors") {
                router.route(to: .colors)
            }
        }
        .navigationTitle("💡 Ideas")
    }

}
