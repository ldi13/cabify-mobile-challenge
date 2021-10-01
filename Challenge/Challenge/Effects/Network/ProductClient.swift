//
//  ProductClient.swift
//  ChallengeCore
//
//  Created by Lorenzo Di Vita on 30/9/21.
//

import Foundation
import Combine
import ComposableArchitecture
import ChallengeCore

private enum ProductClientConfiguration {
    static let liveURL = URL(string: "https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887/Products.json")!
}

struct ProductClient {
    var fetch: () -> Effect<[String: [ProductResponse]], Error>
}

extension ProductClient {
    static let live = Self(
      fetch: {
          Effect.task {
              let (data, urlResponse) = try await URLSession.shared.data(from: ProductClientConfiguration.liveURL)
              let decoder = JSONDecoder()
              return try decoder.decode([String: [ProductResponse]].self, from: data)
        }
      }
    )
}
