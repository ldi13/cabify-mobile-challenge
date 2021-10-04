//
//  AppState.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ComposableArchitecture
import IdentifiedCollections
import ChallengeCore

struct AppState: Equatable {
    var referenceProducts: IdentifiedArrayOf<Product> = []
    var cart: IdentifiedArrayOf<Product> = []
    @BindableState var totalPrice: Double = 0.0
    @BindableState var isPopoverShown: Bool = false
    @BindableState var cartItemsCount: Int = 0
    @BindableState var isAlertShown: Bool = false
}

extension AppState {
    var view: AppView.ViewState {
        get { .init(totalPrice: self.totalPrice, isPopoverShown: self.isPopoverShown, cartItemsCount: self.cartItemsCount, isAlertShown: self.isAlertShown) }
        set {
            self.isPopoverShown = newValue.isPopoverShown
            self.totalPrice = newValue.totalPrice
            self.cartItemsCount = newValue.cartItemsCount
            self.isAlertShown = newValue.isAlertShown
        }
    }
    
    var productListView: ProductListView.ViewState {
        get { .init(referenceProducts: self.referenceProducts) }
        set { self.referenceProducts = newValue.referenceProducts }
    }
    
    var cartDetailsView: CartDetailsView.ViewState {
        get { .init(cart: self.cart, totalPrice: self.totalPrice) }
        set {
            self.cart = newValue.cart
            self.totalPrice = newValue.totalPrice
        }
    }
}
