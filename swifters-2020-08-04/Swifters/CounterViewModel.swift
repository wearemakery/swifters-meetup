import SwiftUI

class CounterViewModel: ObservableObject {
    @Published var counter = 0

    func increment() {
        counter += 1
    }

    func decrement() {
        guard counter > 0 else { return }
        counter -= 1
    }
}
