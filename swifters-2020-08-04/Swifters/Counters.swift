import CasePaths
import ComposableArchitecture

struct CountersState: Equatable {
    var counters: IdentifiedArrayOf<CounterState> = []
    var sum = 0
    var isResetInFlight = false
}

enum CountersAction: Equatable {
    case counter(id: UUID, action: CounterAction)
    case addCounter
    case reset
    case scheduleReset
    case cancelScheduledReset
    case alertDismissed
}

struct CountersEnvironment {
    var uuid: () -> UUID = UUID.init
    var mainQueue: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
}

let countersReducer = Reducer<CountersState, CountersAction, CountersEnvironment> { state, action, environment in
    struct ResetCancellationId: Hashable {}

    switch action {
    case .addCounter:
        state.counters.insert(CounterState(id: environment.uuid()), at: 0)

    case .scheduleReset:
        state.isResetInFlight = true
        return Effect(value: .reset)
            .delay(for: .milliseconds(3000), scheduler: environment.mainQueue)
            .eraseToEffect()
            .cancellable(id: ResetCancellationId(), cancelInFlight: true)

    case .reset:
        state.sum = 0
        state.counters = []
        state.isResetInFlight = false

    case .cancelScheduledReset:
        state.isResetInFlight = false
        return .cancel(id: ResetCancellationId())

    case let .counter(_, action):
        switch action {
        case .increment: state.sum += 1
        case .decrement: state.sum -= 1
        }

    case .alertDismissed:
        break
    }

    return .none
}

let countersAppReducer = Reducer.combine(
    countersReducer,
    counterReducer.forEach(
        state: \.counters,
        action: /CountersAction.counter,
        environment: { _ in }
    )
)

let countersStore = Store(
    initialState: CountersState(),
    reducer: countersAppReducer,
    environment: CountersEnvironment()
)
