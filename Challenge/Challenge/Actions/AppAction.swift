//
//  AppAction.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ChallengeCore
import ComposableArchitecture

enum AppAction: BindableAction, Equatable {
    case addProductToCart(productId: Product.ID)
    case product(id: Product.ID, action: ProductAction)
    case cart(productId: Product.ID, action: CartAction)
    case applyDiscount
    case calculateTotalPrice
    case binding(BindingAction<AppState>)
    case showProductList
    case fetchReferenceProducts
    case referenceProductsResponse(Result<[ProductResponse], Never>)
    case cartItem(productId: Product.ID, action: CartAction)
    case showAlert
}

extension AppAction {
    static func view(_ viewAction: AppView.ViewAction) -> Self {
        switch viewAction {
        case .binding(let action):
            // transform view binding actions into app binding actions
            return .binding(action.pullback(\.view))
            
        case .addProductButtonTapped:
            // route `ViewAction.addProductButtonTapped` to `AppAction.showProductList`
            return .showProductList
        
        case .onAppear:
            return .fetchReferenceProducts
        }
    }
    
    static func productListView(_ viewAction: ProductListView.ViewAction) -> Self {
        switch viewAction {
        case .product(id: let id, action: let action):
            // route `ViewAction.product(id:action:)` to `AppAction.product(id:action:)`
            return .product(id: id, action: action)
        }
    }
    
    static func cartDetailsView(_ viewAction: CartDetailsView.ViewAction) -> Self {
        switch viewAction {
        case .cartItem(productId: let productId, action: let action):
            // route `ViewAction.cartItem(productId:action:)` to `AppAction.cartItem(productId:action:)`
            return .cartItem(productId: productId, action: action)
        }
    }

}

