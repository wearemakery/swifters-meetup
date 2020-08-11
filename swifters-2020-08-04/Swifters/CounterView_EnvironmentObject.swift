import SwiftUI

struct EvenOddView_EnvironmentObject: View {
    @EnvironmentObject var state: CounterStateObject

    var body: some View {
        VStack {
            Text(state.counter % 2 == 0 ? "even" : "odd").font(.title)
        }
    }
}

struct CounterView_EnvironmentObject: View {
    @EnvironmentObject var state: CounterStateObject

    var body: some View {
        VStack {
            VStack {
                Button("Increment") { state.counter += 1 }
                Text("\(state.counter)").font(.system(.title, design: .monospaced))
                Button("Decrement") {
                    if state.counter > 0 { state.counter -= 1 }
                }
            }.fill()
            EvenOddView_EnvironmentObject().fill()
        }
        .navigationTitle("@EnvironmentObject")
    }
}
