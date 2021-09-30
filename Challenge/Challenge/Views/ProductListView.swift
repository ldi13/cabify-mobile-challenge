//
//  ProductListView.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 28/9/21.
//

import SwiftUI
import ComposableArchitecture
import ChallengeCore

struct ProductListView: View {
    let store: Store<ViewState, ViewAction>
    
    var body: some View {
        List {
            ForEachStore(self.store.scope(state: \.referenceProducts, action: ViewAction.product(id:action:)),
            content: ProductView.init(store:))
        }
    }
}

extension ProductListView {
    struct ViewState: Equatable {
        let referenceProducts: IdentifiedArrayOf<Product>
    }
    
    enum ViewAction {
        case product(id: Product.ID, action: ProductAction)
    }
}


