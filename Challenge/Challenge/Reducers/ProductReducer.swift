//
//  ProductReducer.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 29/9/21.
//

import Foundation
import ChallengeCore
import ComposableArchitecture

let productReducer: Reducer<Product, ProductAction, ProductEnvironment> = Reducer { state, action, environment in
    switch action {
    case .productSelected:
        return .none
    }
}
