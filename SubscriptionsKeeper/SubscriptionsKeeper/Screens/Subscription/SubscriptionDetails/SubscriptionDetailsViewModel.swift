//
//  SubscriptionDetailsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 27.04.2026.
//

import SwiftUI

@Observable
final class SubscriptionDetailsViewModel {
    var isActive: Bool { true }

    var perPaymentFormatted: String {
        subscription.cost.formatted(currency: subscription.currency) + " " + subscription.currency.abbreviation
    }

    var yearlyCostFormatted: String {
        let yearly = subscription.paymentCycle == .monthly ? subscription.cost * 12 : subscription.cost
        return yearly.formatted(currency: subscription.currency) + " " + subscription.currency.abbreviation
    }

    var nextPaymentDateFormatted: String {
        let date = nextPaymentDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: date)
    }

    let router: Router
    let subscription: Subscription

    init(router: Router, subscription: Subscription) {
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
