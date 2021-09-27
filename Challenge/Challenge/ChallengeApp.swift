//
//  ChallengeApp.swift
//  Challenge
//
//  Created by Lorenzo Di Vita on 21/9/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer,
                    environment: AppEnvironment(
                        mainQueue: .main,
                        uuid: UUID.init
                    )
                )
            )
        }
    }
}
