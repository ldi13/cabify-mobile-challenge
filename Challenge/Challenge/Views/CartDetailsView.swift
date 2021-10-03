//
//  CartDetailsView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 2/10/21.
//

import SwiftUI
import ComposableArchitecture
import ChallengeCore

struct CartDetailsView: View {
    let store: Store<ViewState, ViewAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEachStore(self.store.scope(state: \.cart, action: ViewAction.cartItem(productId:action:)),
                content: CartItemView.init(store:))
                HStack {
                    Text("Total Price")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(String(format: "%.2f", viewStore.totalPrice)) €")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

extension CartDetailsView {
    struct ViewState: Equatable {
        let cart: IdentifiedArrayOf<Product>
        let totalPrice: Double
    }
    
    enum ViewAction {
        case cartItem(productId: Product.ID, action: CartAction)
    }
}
