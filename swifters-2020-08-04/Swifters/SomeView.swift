import Combine
import Foundation
import SwiftUI

struct SomeView: View {

    private var apiCancellable: AnyCancellable?

    var body: some View {
        Button("Increment") {
            URLSession
                .shared
                .dataTaskPublisher(for: URL(string: "https://my.api/")!)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { (data, response) in }
                )
        }
    }
}
