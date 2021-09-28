//
//  AppAction.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ChallengeCore
import ComposableArchitecture

enum AppAction: BindableAction {
    case addProductToCart(Int)
    case product(id: Product.ID, action: ProductAction)
    case applyDiscount
    case calculateGlobalPrice
    case binding(BindingAction<AppState>)
    case showProductsList
}

extension AppAction {
    static func view(_ viewAction: AppView.ViewAction) -> Self {
        switch viewAction {
        case .binding(let action):
            // transform view binding actions into app binding actions
            return .binding(action.pullback(\.view))
            
        case .addProductButtonTapped:
            // route `ViewAction.addProductButtonTapped` to `AppAction.showProductsList`
            return .showProductsList
        }
    }
}

