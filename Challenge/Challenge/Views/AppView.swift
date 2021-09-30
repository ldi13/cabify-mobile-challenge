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
    @ObservedObject var viewStore: ViewStore<ViewState, ViewAction>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: \.view, action: AppAction.view))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Total Price: \(String(format: "%.2f", self.viewStore.globalPrice)) €")
                    .padding()
                    .font(.title2)
                Spacer()
                Button(action: { self.viewStore.send(.addProductButtonTapped) }) {
                    Text("Add Product")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                .background(.purple)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0.1, trailing: 15))
            .popover(isPresented: self.viewStore.binding(\.$isPopoverShown)) {
                ProductListView(store: self.store.scope(state: \.productListView, action: AppAction.productListView))
            }
            .navigationBarItems(
                trailing:
                    ZStack(alignment: .topTrailing) {
                        Button(action: {}) {
                            Image(systemName: "cart").imageScale(.large)
                        }
                        .foregroundColor(.purple)
                        
                        ZStack {
                            Circle()
                              .foregroundColor(.red)
                            Text("\(viewStore.state.cartItemsCount)")
                                .foregroundColor(.white)
                                .font(Font.system(size: 12))
                        }
                        .frame(width: 16, height: 16)
                        .offset(x: 7, y: 0)
                        .opacity(self.viewStore.state.cartItemsCount == 0 ? 0 : 1)
                    }
            )
        }
    }
}

extension AppView {
    struct ViewState: Equatable {
        @BindableState var globalPrice: Double
        @BindableState var isPopoverShown: Bool
        @BindableState var cartItemsCount: Int
    }
    
    enum ViewAction: BindableAction {
        case addProductButtonTapped
        case binding(BindingAction<ViewState>)
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


