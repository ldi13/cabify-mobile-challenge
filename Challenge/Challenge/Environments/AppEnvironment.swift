//
//  AppEnvironment.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let uuid: () -> UUID
    let productClient: ProductClient
}
