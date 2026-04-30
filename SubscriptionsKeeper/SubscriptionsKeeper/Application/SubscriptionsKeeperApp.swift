//
//  SubscriptionsKeeperApp.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 17.04.2026.
//

import SwiftUI

@main
struct SubscriptionsKeeperApp: App {
    @State private var subscriptionsRepository: SubscriptionsRepositoryImpl
    @State private var userRepository: UserRepositoryImpl

    init() {
        do throws(DatabaseError) {
            _subscriptionsRepository = State(initialValue: try SubscriptionsRepositoryImpl())
            _userRepository = State(initialValue: UserRepositoryImpl())
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(subscriptionsRepository)
                .environment(userRepository)
        }
    }
}
