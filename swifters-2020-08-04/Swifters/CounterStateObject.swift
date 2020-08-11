import SwiftUI

class CounterStateObject: ObservableObject {
    @Published var counter = 0
    // more state over time
}
