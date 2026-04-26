//
//  AddSubscriptionViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

import SwiftUI

@Observable
final class AddSubscriptionViewModel {
    private(set) var subscriptionSections: [SubscriptionSection] = []
    
    private let router: Router
    private let repository: SubscriptionsRepository
    
    init(repository: SubscriptionsRepository, router: Router) {
        self.repository = repository
        self.router = router
    }
    
    func onAppear() {
        subscriptionSections = repository.fetchGroupedSubscriptions()
    }
    
    func subscriptionTapped(_ subscription: Subscription) {
        router.push(SubscriptionRoute.newSubscription(subscription, mode: .create))
    }
}
