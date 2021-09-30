//
//  ProductView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 29/9/21.
//

import SwiftUI
import ComposableArchitecture
import ChallengeCore

struct ProductView: View {
    let store: Store<Product, ProductAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button(action: { viewStore.send(.productSelected) }) {
                    Text(viewStore.state.name)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView()
//    }
//}
