import CasePaths
import ComposableArchitecture
import SwiftUI

struct AdvancedCounter: View {

    let store: Store<CountersState, CountersAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    Text("Sum: ").font(.title)
                    Text("\(viewStore.sum)").font(.system(.title, design: .monospaced))
                }
                .padding([.top, .bottom], 16)
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.counters,
                            action: CountersAction.counter(id:action:)
                        ),
                        content: CounterItemView.init(store:)
                    )
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .actionSheet(
                isPresented: viewStore.binding(
                    get: { $0.isResetInFlight },
                    send: .alertDismissed
                )
            ) {
                ActionSheet(
                    title: Text("Are you sure?"),
                    buttons: [ .cancel(Text("Nope")) { viewStore.send(.cancelScheduledReset) } ]
                )
            }
            .navigationTitle("Advanced Counter")
            .navigationBarItems(
                trailing: HStack(spacing: 20) {
                    Button("Reset") { viewStore.send(.scheduleReset) }.disabled(viewStore.isResetInFlight)
                    Button("Add Counter") { viewStore.send(.addCounter) }
                }
            )
        }
    }
}

struct CounterItemView: View {

    let store: Store<CounterState, CounterAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                Button("Decrement") { viewStore.send(.decrement) }
                Spacer()
                Text("\(viewStore.counter)").font(.system(.body, design: .monospaced))
                Spacer()
                Button("Increment") { viewStore.send(.increment) }
            }
        }
    }
}
