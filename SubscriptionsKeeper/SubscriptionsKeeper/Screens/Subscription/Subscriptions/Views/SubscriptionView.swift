//
//  SubscriptionView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 23.04.2026.
//

import SwiftUI

struct SubscriptionView: View {
    let subscription: Subscription

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
                Text(subscription.cost.formatted(.price(currency: subscription.currency)))
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.primary)

                //TODO: - add display after implementation Settings
//                Text("\(subscription.cost.formatted(.price(currency: subscription.currency))) \(subscription.currency.abbreviation)")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)

                Text(subscription.firstPaymentAt, format: .dateTime.day().month(.abbreviated))
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
        subscription: .preview()
    )
    .padding()
}
