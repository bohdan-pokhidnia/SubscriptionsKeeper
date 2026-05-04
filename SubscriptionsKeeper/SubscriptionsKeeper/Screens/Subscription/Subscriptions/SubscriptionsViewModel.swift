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
        let cost = allSubscriptionsCost * 12
        return cost.formatted(.price(currency: currency))
    }
    
    var subscriptionsCount: String {
        subscriptions.count.description
    }
    
    private var allSubscriptionsCost: Double {
        let average: Double = subscriptions
            .reduce(0.0) { partialResult, subscription in
                partialResult + (subscription.dashboardCost ?? subscription.cost)
            }
        return average
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
            subscriptions = try await fetchDashboardSubscriptions.execute()
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
