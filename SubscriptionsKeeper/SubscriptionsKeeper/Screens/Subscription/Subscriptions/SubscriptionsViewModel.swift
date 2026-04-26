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

    func addSubscriptionButtonTapped() {
        router.present(SubscriptionRoute.addSubscription)
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let subscription = subscriptions[index]
            
            do throws(DatabaseError) {
                try repository.delete(id: subscription.id)
                subscriptions.remove(at: index)
            } catch {
                print("[dev] Error deleting subscription: \(error)")
            }
        }
    }
    
    func subscriptionTapped(_ subscription: Subscription) {
        router.present(SubscriptionRoute.newSubscription(subscription, mode: .edit))
    }
}
