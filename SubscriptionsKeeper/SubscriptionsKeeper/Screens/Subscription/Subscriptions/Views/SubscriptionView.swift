//
//  SubscriptionView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 23.04.2026.
//

import SwiftUI

struct SubscriptionView: View {
    let subscription: Subscription
    let date: String

    private var subtitle: String {
        let cycleAndCurrency = "\(subscription.paymentCycle.displayName) • \(subscription.currency.abbreviation)"
        guard !subscription.description.isEmpty else {
            return cycleAndCurrency
        }
        return "\(subscription.description) • \(cycleAndCurrency)"
    }
    
    var body: some View {
        HStack(spacing: 12) {
            RemoteImageView(stringUrl: subscription.imageUrlString)
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                if let dashboardCost = subscription.formattedConvertedCost() {
                    Text(dashboardCost)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.primary)
                    
                    Text(subscription.cost.formatted(.price(currency: subscription.currency)))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Text(subscription.cost.formatted(.price(currency: subscription.currency)))
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.primary)
                }

                Text(date)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
    }
}

#Preview {
    SubscriptionView(
        subscription: .preview(),
        date: "20 Jan"
    )
    .padding()
}
