import SwiftUI


struct ColorView: View {

    let color: Color

    var body: some View {
        Circle()
            .foregroundColor(color)
            .padding(16)
            .navigationTitle(color.description)
    }

}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(color: .red)
    }
}
