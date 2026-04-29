//
//  SubscriptionsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

@Observable
final class SubscriptionsViewModel {
    private let repository: SubscriptionsRepository
    private let router: Router
    
    private(set) var subscriptions: [Subscription] = []
    var showDeleteAlert = false
    var removedSubscription: Subscription?

    init(repository: SubscriptionsRepository, router: Router) {
        self.repository = repository
        self.router = router
    }
    
    func onAppear() {
        fetchSubscriptions()
    }
    
    func fetchSubscriptions() {
        do throws(DatabaseError) {
            subscriptions = try repository.fetchAll()
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
            try repository.delete(id: subscription.id)
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
