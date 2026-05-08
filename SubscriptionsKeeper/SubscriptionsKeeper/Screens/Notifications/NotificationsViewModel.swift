//
//  NotificationsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 07.05.2026.
//

import SwiftUI

@Observable
final class NotificationsViewModel {
    private let subscriptionsRepository: SubscriptionsRepository
    
    private(set) var subscriptions: [Subscription] = []
    var notificationStates: [UUID: Bool] = [:]

    init(subscriptionsRepository: SubscriptionsRepository) {
        self.subscriptionsRepository = subscriptionsRepository
    }

    func onAppear() {
        do throws(DatabaseError) {
            subscriptions = try subscriptionsRepository.fetchAll()
            for subscription in subscriptions where notificationStates[subscription.id] == nil {
                notificationStates[subscription.id] = false
            }
        } catch {
            print("[dev] Error fetching subscriptions: \(error)")
        }
    }
}
