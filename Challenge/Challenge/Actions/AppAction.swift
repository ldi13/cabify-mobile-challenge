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
}
