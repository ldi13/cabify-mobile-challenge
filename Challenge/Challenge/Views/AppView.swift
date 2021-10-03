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
                Text("Total Price: \(String(format: "%.2f", self.viewStore.totalPrice)) €")
                    .padding()
                    .font(.title2)
                Spacer()
                Button(action: { self.viewStore.send(.addProductButtonTapped) }) {
                    HStack {
                        Text("Add Product")
                            .foregroundColor(.white)
                        // TODO: Fix loaderView animation
//                        LoaderView()
                    }
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
                            NavigationLink(destination: CartDetailsView(store: self.store.scope(state: \.cartDetailsView, action: AppAction.cartDetailsView))) {
                                Image(systemName: "cart").imageScale(.large)
                            }
                            .navigationTitle("")
                        }
                        .foregroundColor(.purple)
                        
                        BadgeView(badgeCount: self.viewStore.cartItemsCount)
                            .offset(x: 7, y: 0)
                    }
            )
        }
        .onAppear { self.viewStore.send(.onAppear) }
    }
}

extension AppView {
    struct ViewState: Equatable {
        @BindableState var totalPrice: Double
        @BindableState var isPopoverShown: Bool
        @BindableState var cartItemsCount: Int
    }
    
    enum ViewAction: BindableAction {
        case onAppear
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
                    uuid: UUID.init,
                    productClient: .live
                )
            )
        )
    }
}


