import ComposableArchitecture
import SwiftUI

struct SimpleCounter: View {
    let store: Store<CounterState, CounterAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Button("Increment") { viewStore.send(.increment) }
                Text("\(viewStore.counter)").font(.system(.title, design: .monospaced))
                Button("Decrement") { viewStore.send(.decrement) }
            }
            .navigationTitle("Simple Counter")
        }
    }
}
