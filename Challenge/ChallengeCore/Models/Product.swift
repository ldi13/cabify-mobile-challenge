//
//  Product.swift
//  ChallengeCore
//
//  Created by Lorenzo Di Vita on 22/9/21.
//

import Foundation

public struct Product {
    public enum CodeType: String {
        case VOUCHER
        case TSHIRT
        case MUG
    }
    
    public let code: CodeType
    public let name: String
    public let regularPrice: Double
    public var priceAfterDiscount: Double?
    
    public init(code: CodeType, name: String, regularPrice: Double) {
        self.code = code
        self.name = name
        self.regularPrice = regularPrice
    }
}
