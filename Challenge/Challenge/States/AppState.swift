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
    let referenceProducts: IdentifiedArrayOf<Product> = .mock
    var cart: IdentifiedArrayOf<Product> = []
    var globalPrice: Double = 0.0
}

extension IdentifiedArray where ID == Product.ID, Element == Product {
    static let mock: Self = [
        Product(
            id: UUID(uuidString: "EAD11112-1234-1235-DEAF-FEED1313BEEF")!,
            code: .voucher,
            name: "Voucher",
            regularPrice: 5.0
        ),
        Product(
            id: UUID(uuidString: "CAFE4321-CAFE-1234-CAFE-BEADBEED1234")!,
            code: .tshirt,
            name: "T-shirt",
            regularPrice: 20.0
        ),
        Product(
            id: UUID(uuidString: "D00D1313-D00D-CAFE-D00D-CAFED00DCAFE")!,
            code: .mug,
            name: "Mug",
            regularPrice: 7.5
        )
    ]
}
