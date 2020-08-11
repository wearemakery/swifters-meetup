import ComposableArchitecture
@testable import Swifters_08_04
import XCTest

class CounterTests: XCTestCase {
    let testScheduler = DispatchQueue.testScheduler

    func test_SimpleCounter() throws {
        let testStore = TestStore(
            initialState: CounterState(id: UUID()),
            reducer: counterReducer,
            environment: CounterEnvironment()
        )

        testStore.assert(
            .send(.increment) { $0.counter = 1 },
            .send(.increment) { $0.counter = 2 },
            .send(.decrement) { $0.counter = 1 }
        )
    }

    func test_AdvancedCounter() throws {
        let testStore = TestStore(
            initialState: CountersState(),
            reducer: countersAppReducer,
            environment: CountersEnvironment(
                uuid: UUID.incrementing,
                mainQueue: testScheduler.eraseToAnyScheduler()
            )
        )

        testStore.assert(
            .send(.addCounter) {
                $0.counters.insert(
                    CounterState(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!),
                    at: 0
                )
            },
            .send(.addCounter) {
                $0.counters.insert(
                    CounterState(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!),
                    at: 0
                )
            },
            .send(.counter(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                action: .increment
            )) {
                $0.counters = [
                    CounterState(counter: 1, id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!),
                    CounterState(counter: 0, id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!)
                ]
                $0.sum = 1
            },
            .send(.scheduleReset) { $0.isResetInFlight = true },
            // .do { self.testScheduler.advance(by: 1) },
            // .send(.cancelScheduledReset) { $0.isResetInFlight = false },
            // .send(.scheduleReset) { $0.isResetInFlight = true },
            .do { self.testScheduler.advance(by: 3) },
            .receive(.reset) {
                $0.counters = []
                $0.sum = 0
                $0.isResetInFlight = false
            }
        )
    }
}

extension UUID {
    static var incrementing: () -> UUID {
        var uuid = 0
        return {
            defer { uuid += 1 }
            return UUID(uuidString: "00000000-0000-0000-0000-\(String(format: "%012x", uuid))")!
        }
    }
}
