//
//  NewSubscriptionViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 22.04.2026.
//

import SwiftUI

@Observable
final class NewSubscriptionViewModel {
    enum Mode {
        case create
        case edit
    }
    
    private let repository: SubscriptionsRepository
    private let router: Router
    var subscription: Subscription
    let mode: Mode
    var title: String
    var cost: String
    
    init(
        repository: SubscriptionsRepository,
        router: Router,
        subscription: Subscription,
        mode: Mode
    ) {
        self.repository = repository
        self.router = router
        self.subscription = subscription
        self.mode = mode
        
        title = mode == .create ? "New Subscription" : "Edit Subscription"
        cost = String(subscription.cost.description.split(separator: ".0").first ?? "-")
            .replacingOccurrences(of: ".", with: ",")
    }
    
    func cancelButtonTapped() {
        router.dismiss()
    }
    
    func saveButtonTapped() {
        if let formattedCost = Double(cost.replacingOccurrences(of: ",", with: ".")) {
            subscription.cost = formattedCost
        }
        
        switch mode {
        case .create:
            add(subscription: subscription)
            
        case .edit:
            update(subscription: subscription)
        }
    }
}

private extension NewSubscriptionViewModel {
    func add(subscription: Subscription) {
        do throws(DatabaseError) {
           try repository.add(subscription: subscription, id: UUID())
           router.dismiss()
        } catch {
            print("[dev] error when add subscription: \(error)")
        }
    }
    
    func update(subscription: Subscription) {
        do throws(DatabaseError) {
            try repository.update(id: subscription.id, with: subscription)
            router.dismiss()
        } catch {
            print("[dev] error when update subscription: \(error)")
        }
    }
}
