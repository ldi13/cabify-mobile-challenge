import Foundation
import ComposableArchitecture
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    @State private var score = 0

    var body: some View {
        NavigationView {
            Text("Score: \(score)")
                .navigationTitle("Navigation")
                .navigationBarItems(
                    trailing:
                        Button(action: { self.score += 1 }) {
                            Image(systemName: "cart").imageScale(.large)
                        }
                        .foregroundColor(.purple)
                )
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())





