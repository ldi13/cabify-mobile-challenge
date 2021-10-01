//
//  ProductResponse.swift
//  ChallengeCore
//
//  Created by Lorenzo Di Vita on 30/9/21.
//

import Foundation

public struct ProductResponse: Decodable {
    public let code: ProductCode
    public let name: String
    public let price: Double
}
