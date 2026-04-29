//
//  UserSubscription.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 23.04.2026.
//

import SwiftData
import Foundation

@Model
final class UserSubscription {
    @Attribute(.unique)
    var id: UUID
    var identifierRawValue: String
    var groupRawValue: String
    var name: String
    var subscriptionDescription: String
    var cost: Double
    var currencyRawValue: String
    var paymentCycleRawValue: String
    var firstPaymentAt: Date

    init(
        id: UUID,
        identifierRawValue: String,
        groupRawValue: String,
        name: String,
        subscriptionDescription: String,
        cost: Double,
        currencyRawValue: String,
        paymentCycleRawValue: String,
        createdAt: Date
    ) {
        self.id = id
        self.identifierRawValue = identifierRawValue
        self.groupRawValue = groupRawValue
        self.name = name
        self.subscriptionDescription = subscriptionDescription
        self.cost = cost
        self.currencyRawValue = currencyRawValue
        self.paymentCycleRawValue = paymentCycleRawValue
        self.firstPaymentAt = createdAt
    }
}

extension UserSubscription: DatabaseRecord {
    convenience init(from subscription: Subscription, id: UUID) {
        self.init(
            id: id,
            identifierRawValue: subscription.identifier.rawValue,
            groupRawValue: String(describing: subscription.group),
            name: subscription.name,
            subscriptionDescription: subscription.description,
            cost: subscription.cost,
            currencyRawValue: subscription.currency.rawValue,
            paymentCycleRawValue: subscription.paymentCycle.rawValue,
            createdAt: subscription.firstPaymentAt
        )
    }

    func toDomainModel() -> Subscription? {
        guard
            let identifier = SubscriptionIdentifier(rawValue: identifierRawValue),
            let group = SubscriptionGroup.allCases.first(where: { String(describing: $0) == groupRawValue }),
            let currency = Currency(rawValue: currencyRawValue),
            let paymentCycle = PaymentCycle(rawValue: paymentCycleRawValue)
        else {
            return nil
        }
        return Subscription(
            id: id,
            identifier: identifier,
            group: group,
            name: name,
            description: subscriptionDescription,
            cost: cost,
            currency: currency,
            paymentCycle: paymentCycle,
            firstPaymentAt: firstPaymentAt
        )
    }

    func update(from model: Subscription) {
        name = model.name
        subscriptionDescription = model.description
        cost = model.cost
        currencyRawValue = model.currency.rawValue
        paymentCycleRawValue = model.paymentCycle.rawValue
        firstPaymentAt = model.firstPaymentAt
    }
}
