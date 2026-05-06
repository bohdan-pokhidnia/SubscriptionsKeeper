//
//  SubscriptionsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

@MainActor
@Observable
final class SubscriptionsViewModel {
    var monthlyAverage: String {
        allSubscriptionsCost.formatted(.price(currency: currency))
    }
    
    var yearly: String {
        (allSubscriptionsCost * 12).formatted(.price(currency: currency))
    }
    
    var subscriptionsCount: String {
        subscriptions.count.description
    }
    
    private var allSubscriptionsCost: Double {
        subscriptions.reduce(0.0) { partialResult, subscription in
            partialResult + (subscription.dashboardCost ?? subscription.cost)
        }
    }
    
    private var currency: Currency {
        userRepository.currentCurrency
    }
    
    private(set) var subscriptions: [Subscription] = []
    var showDeleteAlert = false
    var removedSubscription: Subscription?

    private let subscriptionsRepository: SubscriptionsRepository
    private let fetchDashboardSubscriptions: FetchDashboardSubscriptionsUseCase
    private let userRepository: UserRepository
    private let router: Router

    init(
        subscriptionsRepository: SubscriptionsRepository,
        fetchDashboardSubscriptions: FetchDashboardSubscriptionsUseCase,
        userRepository: UserRepository,
        router: Router
    ) {
        self.subscriptionsRepository = subscriptionsRepository
        self.fetchDashboardSubscriptions = fetchDashboardSubscriptions
        self.userRepository = userRepository
        self.router = router
    }
    
    func onAppear() async {
        await fetchSubscriptions()
    }
    
    func fetchSubscriptions() async {
        do throws(DatabaseError) {
            subscriptions = try await fetchDashboardSubscriptions
                .execute()
                .sorted(by: { nextPaymentDate(for: $0) < nextPaymentDate(for: $1) })
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
    
    func nextPaymentDateString(subscription: Subscription) -> String {
        let date = nextPaymentDate(for: subscription)
        return date.formatted(.dateTime.day().month(.abbreviated))
    }
}

private extension SubscriptionsViewModel {
    func nextPaymentDate(for subscription: Subscription) -> Date {
        let calendar = Calendar.current
        let today = Date.now
        let paymentDay = calendar.component(.day, from: subscription.firstPaymentAt)

        var components = calendar.dateComponents([.year, .month], from: today)
        components.day = paymentDay

        guard var date = calendar.date(from: components) else {
            return .now
        }

        if date < today {
            guard let nextMonth = calendar.date(byAdding: .month, value: 1, to: date) else {
                return .now
            }
            date = nextMonth
        }
        
        return date
    }
}
