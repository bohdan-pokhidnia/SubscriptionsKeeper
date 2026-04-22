//
//  SubscriptionRoute.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

enum SubscriptionRoute: Hashable, Identifiable {
    var id: Self { self }
    
    case addSubscription
}
