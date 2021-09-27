//
//  AppEnvironment.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 27/9/21.
//

import Foundation
import ComposableArchitecture

public struct AppEnvironment {
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var uuid: () -> UUID
}
