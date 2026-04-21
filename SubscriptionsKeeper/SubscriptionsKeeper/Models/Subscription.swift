//
//  Subscription.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

struct Subscription {
    var imageUrlString: String { identifier.imageUrlString }
    
    let identifier: SubscriptionIdentifier
    let name: String
}
