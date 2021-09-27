//
//  AppReducer.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ChallengeCore
import ComposableArchitecture

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    productReducer.forEach(
        state: \.cart,
        action: /AppAction.product(id:action:),
        environment: { _ in ProductEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case .addProductToCart(let index):
            let productToAdd = state.referenceProducts[index]
            
            state.cart.append(
                Product(
                    id: environment.uuid(),
                    code: productToAdd.code,
                    name: productToAdd.name,
                    regularPrice: productToAdd.regularPrice
                )
            )
            
            return Effect(value: .applyDiscount)
            
        case .product(id: let id, action: let action):
            struct ApplyDiscountCompletionId: Hashable {}
            return Effect(value: .calculateGlobalPrice)
                .debounce(id: ApplyDiscountCompletionId(), for: 1, scheduler: environment.mainQueue.animation())
            
        case .applyDiscount:
            return applyDiscount(on: state.cart)
            
        case .calculateGlobalPrice:
            state.globalPrice = state.cart.reduce(0) { $0 + $1.priceAfterDiscount }
            return .none
        }
    }
)
.debug()

private func applyDiscount(on products: IdentifiedArrayOf<Product>) -> Effect<AppAction, Never> {
    var effects: [Effect<AppAction, Never>] = []
    
    //Discount predicate for vouchers
    var applyVoucherDiscount = false
    
    //Discount predicate for t-shirts
    let applyTshirtDiscount = products.filter({
        if case .tshirt = $0.code {
            return true
        } else {
            return false
        }
    }).capacity >= 3
    
   products.forEach { product in
        switch product.code {
        case .voucher:
            effects.append(buildEffectWith(applyDiscount: applyVoucherDiscount, product: product))
            applyVoucherDiscount = !applyVoucherDiscount

        case .tshirt:
            effects.append(buildEffectWith(applyDiscount: applyTshirtDiscount, product: product))

        case .mug:
            effects.append(buildEffectWith(applyDiscount: false, product: product))
        }
    }
    
    return .concatenate(effects)
}

private func buildEffectWith(applyDiscount: Bool, product: Product) -> Effect<AppAction, Never> {
    let localAction: ProductAction = .applyDiscount(applyDiscount)
    let globaleAction: AppAction  = .product(
        id: product.id,
        action: localAction
    )
    
    return Effect(value: globaleAction)
}
