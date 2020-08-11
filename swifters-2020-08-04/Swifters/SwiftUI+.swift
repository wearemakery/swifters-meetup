import SwiftUI

extension View {
    func fill() -> some View {
        frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}
