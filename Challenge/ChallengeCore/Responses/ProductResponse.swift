//
//  ProductResponse.swift
//  ChallengeCore
//
//  Created by Lorenzo Di Vita on 30/9/21.
//

import Foundation

public struct ProductResponse: Decodable, Equatable {
    public let code: ProductCode
    public let name: String
    public let price: Double
}

extension Array where Element == ProductResponse {
    public static let mock: Self = [
        ProductResponse(
            code: .voucher,
            name: "Voucher",
            price: 5.0
        ),
        ProductResponse(
            code: .tshirt,
            name: "T-shirt",
            price: 20.0
        ),
        ProductResponse(
            code: .mug,
            name: "Mug",
            price: 7.5
        )
    ] 
}
