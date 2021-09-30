//
//  CartReducer.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ChallengeCore
import ComposableArchitecture

let cartReducer: Reducer<Product, CartAction, CartEnvironment> = Reducer { state, action, environment in
    switch action {
    case .applyDiscount(let hasDiscount):
        state.hasDiscount = hasDiscount
        return .none
    }
}
