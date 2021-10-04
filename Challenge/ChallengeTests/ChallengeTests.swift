//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Lorenzo Di Vita on 21/9/21.
//

import XCTest
import ComposableArchitecture
import ChallengeCore
@testable import Challenge

class ChallengeTests: XCTestCase {
  let scheduler = DispatchQueue.test

    func testFetchProductsOK() {
      let store = TestStore(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment(
            mainQueue: self.scheduler.eraseToAnyScheduler(),
            uuid: UUID.incrementing,
            productClient: .testFetchOK
        )
      )
      
      store.send(.fetchReferenceProducts) { _ in }
      
      self.scheduler.advance(by: .seconds(1))
      store.receive(.referenceProductsResponse(.success(.mock))) {
          $0.referenceProducts.append(.product0)
          $0.referenceProducts.append(.product1)
          $0.referenceProducts.append(.product2)
      }
      
      self.scheduler.run()
    }
    
    func testFetchProductsKO() {
        let store = TestStore(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment(
              mainQueue: self.scheduler.eraseToAnyScheduler(),
              uuid: UUID.incrementing,
              productClient: .testFetchKO
          )
        )
        
        store.send(.fetchReferenceProducts) { _ in }
        
        self.scheduler.advance(by: .seconds(1))
        store.receive(.referenceProductsResponse(.success([]))) { _ in }
        
        store.receive(.showAlert) { $0.isAlertShown = true }
        
        self.scheduler.run()
    }
}

extension UUID {
  // A deterministic, auto-incrementing "UUID" generator for testing.
  static var incrementing: () -> UUID {
    var uuid = 0
    return {
      defer { uuid += 1 }
      return UUID(uuidString: "00000000-0000-0000-0000-\(String(format: "%012x", uuid))")!
    }
  }
}

extension Product {
    static let product0 = Product(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
        code: .voucher,
        name: "Voucher",
        regularPrice: 5.0
    )
    
    static let product1 = Product(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        code: .tshirt,
        name: "T-shirt",
        regularPrice: 20.0
    )
    
    static let product2 = Product(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
        code: .mug,
        name: "Mug",
        regularPrice: 7.5
    )
}

extension IdentifiedArrayOf where ID == Product.ID, Element == Product {
    static let mock: Self =  [
        .product0,
        .product1,
        .product2
    ]
}
