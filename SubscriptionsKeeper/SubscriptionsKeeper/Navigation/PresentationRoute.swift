//
//  PresentationRoute.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

enum PresentationRoute: Hashable, Identifiable {
    var id: Self { self }
    
    case addSubscription
    case newSubscription(_ subscription: Subscription, mode: NewSubscriptionViewModel.Mode)
    case details(subscription: Subscription)
    case settings
}
