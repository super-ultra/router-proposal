import SwiftUI


struct IdeaSetView: View {

    let router: IdeaSetRouter

    var body: some View {
        List {
            Button("Colors") {
                router.route(to: .colors())
            }
        }
        .toolbar {
            Button("RED!") {
                router.route(to: .colors(next: .color(.red)))
            }
        }
        .navigationTitle("💡 Ideas")
        .navigationBarTitleDisplayMode(.large)
    }

}
