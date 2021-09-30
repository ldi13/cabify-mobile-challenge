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
        state: \.referenceProducts,
        action: /AppAction.product(id:action:),
        environment: { _ in ProductEnvironment() }
    ),
    cartReducer.forEach(
        state: \.cart,
        action: /AppAction.cart(productId:action:),
        environment: { _ in CartEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case .addProductToCart(productId: let productId):
            guard let productToAdd = state.referenceProducts.first(where: { $0.id == productId }) else { return .none }
            
            state.cart.append(
                Product(
                    id: environment.uuid(),
                    code: productToAdd.code,
                    name: productToAdd.name,
                    regularPrice: productToAdd.regularPrice
                )
            )
            
            return Effect(value: .applyDiscount)
            
        case .cart(productId: let productId, action: .applyDiscount):
            struct ApplyDiscountCompletionId: Hashable {}
            return Effect(value: .calculateTotalPrice)
                .debounce(id: ApplyDiscountCompletionId(), for: 0.1, scheduler: environment.mainQueue.animation())
        
        case .product(id: let id, action: .productSelected):
            state.isPopoverShown = false
            return Effect(value: .addProductToCart(productId: id))
            
        case .applyDiscount:
            return applyDiscount(on: state.cart)
            
        case .calculateTotalPrice:
            state.totalPrice = state.cart.reduce(0) { $0 + $1.priceAfterDiscount }
            state.cartItemsCount = state.cart.count
            return .none
        
        case .showProductList:
            state.isPopoverShown = true
            return .none
        
        case .binding(\.$isPopoverShown):
            let isPopoverShownBinding = state[keyPath: \.$isPopoverShown].wrappedValue
            state.isPopoverShown = isPopoverShownBinding
            return .none
            
        case .binding:
            return .none
        }
    }
    .binding()
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
    let localAction: CartAction = .applyDiscount(applyDiscount)
    let globaleAction: AppAction  = .cart(
        productId: product.id,
        action: localAction
    )
    
    return Effect(value: globaleAction)
}
