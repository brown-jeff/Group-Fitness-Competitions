import SwiftUI

struct IDPill: View {

    let id: String

    var body: some View {
        Text(id)
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
    }
}
