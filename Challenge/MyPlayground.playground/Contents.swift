import UIKit
import ChallengeCore

let products = [
    Product(
        code: .VOUCHER,
        name: "test",
        regularPrice: 5.0
    ),
    Product(
        code: .VOUCHER,
        name: "test2",
        regularPrice: 5.0
    ),
    Product(
        code: .VOUCHER,
        name: "test3",
        regularPrice: 5.0
    ),
    Product(
        code: .VOUCHER,
        name: "test4",
        regularPrice: 5.0
    ),
    Product(
        code: .TSHIRT,
        name: "test5",
        regularPrice: 20.0
    ),
    Product(
        code: .TSHIRT,
        name: "test6",
        regularPrice: 20.0
    ),
    Product(
        code: .TSHIRT,
        name: "test7",
        regularPrice: 20.0
    ),
    Product(
        code: .MUG,
        name: "test8",
        regularPrice: 7.5
    )
]


func getPriceAfterDiscount(for products: [Product]) -> Double {
    var priceAfterDiscount = 0.0
    var applyVoucherDiscount = false
    
    // TSHIRT "3 or more" predicate
    let applyTshirtDiscount = products.filter({
        if case .TSHIRT = $0.code {
            return true
        } else {
            return false
        }
    }).capacity >= 3
    
    products.forEach { product in
        switch product.code {
        case .VOUCHER:
            // VOUCHER "2-1" predicate
            if applyVoucherDiscount {
                priceAfterDiscount += Product.CodeType.VOUCHER.priceAfterDiscount
                applyVoucherDiscount = false
            } else {
                priceAfterDiscount += product.regularPrice
                applyVoucherDiscount = true
            }
            
        case .TSHIRT:
            priceAfterDiscount += applyTshirtDiscount ? Product.CodeType.TSHIRT.priceAfterDiscount : product.regularPrice
            
        default:
            priceAfterDiscount += product.regularPrice
        }
    }
    
    return priceAfterDiscount
}

getPriceAfterDiscount(for: products)





