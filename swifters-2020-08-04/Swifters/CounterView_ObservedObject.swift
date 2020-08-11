import SwiftUI

struct CounterView_ObservedObject: View {
    @ObservedObject var state: CounterStateObject

    var body: some View {
        VStack {
            Button("Increment") { state.counter += 1 }
            Text("\(state.counter)").font(.system(.title, design: .monospaced))
            Button("Decrement") { state.counter -= 1 }
        }
        .navigationTitle("@ObservedObject")
    }
}
