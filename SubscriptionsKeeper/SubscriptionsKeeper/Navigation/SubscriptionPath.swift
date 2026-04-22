//
//  SubscriptionPath.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 22.04.2026.
//

enum SubscriptionPath: Hashable, Equatable {
    case newSubscription(_ subscription: Subscription)
}
