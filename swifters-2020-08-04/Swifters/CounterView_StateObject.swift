import SwiftUI

struct EvenOddView: View {
    @StateObject var state: CounterStateObject

    var body: some View {
        VStack {
            Text(state.counter % 2 == 0 ? "even" : "odd").font(.title)
        }
    }
}

struct CounterView_StateObject: View {
    @StateObject var state = CounterStateObject()

    var body: some View {
        VStack {
            VStack {
                Button("Increment") { state.counter += 1 }
                Text("\(state.counter)").font(.system(.title, design: .monospaced))
                Button("Decrement") { state.counter -= 1 }
            }.fill()
            EvenOddView(state: state).fill()
        }
        .navigationTitle("@StateObject")
    }
}
