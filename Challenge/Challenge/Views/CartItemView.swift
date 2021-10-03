//
//  CartItem.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 3/10/21.
//

import SwiftUI
import ComposableArchitecture
import ChallengeCore

struct CartItemView: View {
    let store: Store<Product, CartAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Text("\(viewStore.name)")
                Spacer()
                Text("\(String(format: "%.2f", viewStore.regularPrice)) €")
                    .strikethrough(viewStore.hasDiscount, color: .purple)
                if viewStore.hasDiscount {
                    Spacer()
                    Text("\(String(format: "%.2f", viewStore.priceAfterDiscount)) €")
                        .foregroundColor(.purple)
                }
            }
        }
    }
}
