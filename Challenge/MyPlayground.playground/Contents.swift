import Foundation
import ComposableArchitecture

let store: Store<AppState, AppAction> = Store(
    initialState: AppState(),
    reducer: appReducer,
    environment: AppEnvironment(
      mainQueue: .main,
      uuid: UUID.init
    )
)

let viewStore: ViewStore<AppState, AppAction> = ViewStore(store)

viewStore.send(.addProductToCart(0))
viewStore.send(.addProductToCart(1))
viewStore.send(.addProductToCart(1))
viewStore.send(.addProductToCart(1))





