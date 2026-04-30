//
//  SubscriptionsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

@Observable
final class SubscriptionsViewModel {
    private let subscriptionsRepository: SubscriptionsRepository
    private let userRepository: UserRepository
    private let router: Router
    
    private(set) var subscriptions: [Subscription] = []
    var showDeleteAlert = false
    var removedSubscription: Subscription?

    init(
        subscriptionsRepository: SubscriptionsRepository,
        userRepository: UserRepository,
        router: Router
    ) {
        self.subscriptionsRepository = subscriptionsRepository
        self.userRepository = userRepository
        self.router = router
    }
    
    func onAppear() {
        fetchSubscriptions()
    }
    
    func fetchSubscriptions() {
        do throws(DatabaseError) {
            subscriptions = try subscriptionsRepository.fetchAll()
        } catch {
            print("[dev] Error fetching subscriptions: \(error)")
        }
    }
    
    func settingsButtonTapped() {
        router.present(.settings)
    }

    func addSubscriptionButtonTapped() {
        router.present(PresentationRoute.addSubscription)
    }

    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        removedSubscription = subscriptions[index]
        showDeleteAlert = true
    }

    func deleteConfirmed() {
        guard let subscription = removedSubscription else { return }
        do throws(DatabaseError) {
            try subscriptionsRepository.delete(id: subscription.id)
            subscriptions.removeAll { $0.id == subscription.id }
        } catch {
            print("[dev] Error deleting subscription: \(error)")
        }
        removedSubscription = nil
    }
    
    func subscriptionTapped(_ subscription: Subscription) {
        router.fullScreenPresent(PresentationRoute.details(subscription: subscription))
    }
}
