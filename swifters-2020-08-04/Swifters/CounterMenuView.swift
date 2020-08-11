import SwiftUI

let counterState = CounterStateObject()

let counterViewModel = CounterViewModel()

struct CounterMenuView: View {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vanilla")) {
                    NavigationLink(
                        "Counter with @State",
                        destination: CounterView_State()
                    )
                    NavigationLink(
                        "Counter with @StateObject",
                        destination: CounterView_StateObject()
                    )
                    NavigationLink(
                    "Counter with @ObservedObject",
                        destination: CounterView_ObservedObject(state: counterState)
                    )
                    NavigationLink(
                        "Counter with @EnvironmentObject",
                        destination: CounterView_EnvironmentObject()
                            .environmentObject(counterState)
                    )
                    NavigationLink(
                        "Counter with ViewModel",
                        destination: CounterView_ViewModel(viewModel: counterViewModel)
                    )
                }
                Section(header: Text("Composable Architecture")) {
                    NavigationLink(
                        "Simple Counter",
                        destination: SimpleCounter(store: counterStore)
                    )
                    NavigationLink(
                        "Advanced Counter",
                        destination: AdvancedCounter(store: countersStore)
                    )
                }
            }
            .navigationBarTitle("Counters")
        }
    }
}
