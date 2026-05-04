//
//  SubscriptionsKeeperApp.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 17.04.2026.
//

import SwiftUI

@main
struct SubscriptionsKeeperApp: App {
    @State private var userRepository: UserRepositoryImpl
    @State private var rateRepository: RateRepositoryImpl
    @State private var subscriptionsRepository: SubscriptionsRepositoryImpl

    init() {
        do throws(DatabaseError) {
            let userRepository = UserRepositoryImpl()
            let rateRepository = RateRepositoryImpl()
            
            _userRepository = State(initialValue: userRepository)
            _rateRepository = State(initialValue: rateRepository)
            _subscriptionsRepository = State(initialValue: try SubscriptionsRepositoryImpl())
        } catch {
            fatalError("Failed to initialize database: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(subscriptionsRepository)
                .environment(userRepository)
                .environment(rateRepository)
        }
    }
}
