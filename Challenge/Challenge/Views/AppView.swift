//
//  ContentView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 21/9/21.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    
    let store: Store<AppState, AppAction>
    @ObservedObject var viewStore: ViewStore<AppState, AppAction>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Global Price: \(String(format: "%.2f", self.viewStore.globalPrice)) €")
                .padding()
                .font(.title2)
            Spacer()
            Button(action: { self.viewStore.send(.addProductToCart(0)) }) {
                Text("Add Product")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(.purple)
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0.1, trailing: 15))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                    mainQueue: .main,
                    uuid: UUID.init
                )
            )
        )
    }
}
