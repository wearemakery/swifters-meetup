import SwiftUI

struct CounterView_State: View {

    @State private var counter = 0

    var body: some View {
        VStack {
            Button("Increment") { counter += 1 }
            Text("\(counter)").font(.system(.title, design: .monospaced))
            Button("Decrement") { counter -= 1 }
        }
        .navigationTitle("@State")
    }
}
