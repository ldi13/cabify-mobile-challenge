//
//  Product.swift
//  ChallengeCore
//
//  Created by Lorenzo Di Vita on 22/9/21.
//

import Foundation

public struct Product: Equatable, Identifiable {
    public var discount: Discount {
        switch self.code {
        case .voucher:
            return .full
        case .tshirt:
            return .partial(1.0)
        default:
            return .none
        }
    }
    
    public var priceAfterDiscount: Double {
        guard self.hasDiscount else { return self.regularPrice }
        
        switch self.discount {
        case .full:
            return 0.0
        case .partial(let discountToApply):
            return regularPrice - discountToApply
        case .none:
            return regularPrice
        }
    }
    
    public let id: UUID
    public let code: ProductCode
    public let name: String
    public let regularPrice: Double
    public var hasDiscount: Bool
    
    public init(id: UUID, code: ProductCode, name: String, regularPrice: Double, hasDiscount: Bool = false) {
        self.id = id
        self.code = code
        self.name = name
        self.regularPrice = regularPrice
        self.hasDiscount = hasDiscount
    }
}

