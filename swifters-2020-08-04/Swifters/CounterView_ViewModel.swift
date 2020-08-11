import SwiftUI

struct CounterView_ViewModel: View {
    @ObservedObject var viewModel: CounterViewModel

    var body: some View {
        VStack {
            Button("Increment") { viewModel.increment() }
            Text("\(viewModel.counter)").font(.system(.title, design: .monospaced))
            Button("Decrement") { viewModel.decrement() }
        }
        .navigationTitle("ViewModel")
    }
}
