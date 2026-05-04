//
//  SubscriptionDetailsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 27.04.2026.
//

import SwiftUI

@Observable
final class SubscriptionDetailsViewModel {
    var showDeleteAlert = false
    var isActive: Bool { true }

    var perPaymentFormatted: String {
        subscription.cost.formatted(.price(currency: subscription.currency))
    }

    var yearlyCostFormatted: String {
        subscription.yearlyCost.formatted(.price(currency: subscription.currency))
    }

    var nextPaymentDateFormatted: String {
        let date = nextPaymentDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    }

    var showDashboardValues: Bool {
        userRepository.showDashboardValues(for: subscription.currency)
    }

    private let subscriptionsRepository: SubscriptionsRepository
    private let userRepository: UserRepository
    let router: Router
    let subscription: Subscription

    init(
        subscriptionsRepository: SubscriptionsRepository,
        userRepository: UserRepository,
        router: Router,
        subscription: Subscription
    ) {
        self.subscriptionsRepository = subscriptionsRepository
        self.userRepository = userRepository
        self.router = router
        self.subscription = subscription
    }
    
    func closeButtonTapped() {
        router.dismiss()
    }
    
    func editButtonTapped() {
        router.dismiss()
        router.present(.newSubscription(subscription, mode: .edit))
    }
    
    func removeButtonTapped() {
        showDeleteAlert = true
    }

    func deleteConfirmed() {
        do {
            try subscriptionsRepository.delete(id: subscription.id)
            router.dismiss()
        } catch {
            print("[dev] error when remove subscription: \(error)")
        }
    }
}

private extension SubscriptionDetailsViewModel {
    func nextPaymentDate() -> Date {
        let calendar = Calendar.current
        let now = Date.now
        var next = subscription.firstPaymentAt
        let component: Calendar.Component = subscription.paymentCycle == .monthly ? .month : .year
        while next <= now {
            next = calendar.date(byAdding: component, value: 1, to: next) ?? next
        }
        return next
    }
}
