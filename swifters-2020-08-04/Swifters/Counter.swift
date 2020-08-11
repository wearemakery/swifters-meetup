import ComposableArchitecture

struct CounterState: Equatable, Identifiable {
    var counter = 0
    let id: UUID
}

enum CounterAction {
    case increment
    case decrement
}

typealias CounterEnvironment = Void

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, _ in
    switch action {
    case .increment: state.counter += 1
    case .decrement: state.counter -= 1
    }
    return .none
}

let counterStore = Store(
    initialState: CounterState(id: UUID()),
    reducer: counterReducer,
    environment: CounterEnvironment()
)
